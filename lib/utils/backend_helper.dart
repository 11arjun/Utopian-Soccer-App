import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utopiansoccer/utils/url_helper.dart';
import 'package:intl/intl.dart';

class BackendHelper {
  static const String _apiBaseUrl = backendUrl;
  static const Map<String, String> _headers = {
    "content-Type": "application/json",
    "Accept": "application/json",
  };
  static Map<String, dynamic>? _csrfToken;
  BackendHelper._privateConstructor();
  static final BackendHelper instance = BackendHelper._privateConstructor();
  static SharedPreferences? _sharedPreferences;
  static Dio? _backendHelper;

  Future<Dio> get backendHelper async {
    if (_backendHelper != null) return _backendHelper!;
    _backendHelper = await _initBackendHelper();
    return _backendHelper!;
  }

  Future<SharedPreferences> get sharedPreferences async {
    if (_sharedPreferences != null) return _sharedPreferences!;
    _sharedPreferences = await _initSharedPreferences();
    return _sharedPreferences!;
  }

  _initBackendHelper() async {
    _backendHelper = Dio();
    _backendHelper!.options.baseUrl = _apiBaseUrl;
    _backendHelper!.options.headers = _headers;
    Directory directory = await getApplicationDocumentsDirectory();
    String appPath = directory.path;

    CookieJar cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(appPath + '/.utopian/'),
    );
    _backendHelper!.interceptors.add(CookieManager(cookieJar));
    return _backendHelper;
  }

  _initSharedPreferences() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> _loadCsrf() async {
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    if (_csrfToken != null &&
        _csrfToken!['expiry'].millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch) {
      return _csrfToken!;
    }
    String? token = sharedPreferences.getString('csrf_token');
    int? expiry = sharedPreferences.getInt('csrf_token_expiry');
    if (token != null &&
        expiry != null &&
        expiry > DateTime.now().millisecondsSinceEpoch) {
      _csrfToken = {
        'token': token,
        'expiry': DateTime.fromMillisecondsSinceEpoch(expiry),
      };
    } else {
      var generatedResponse = await _generateCsrf();
      if (generatedResponse['status'] == "success") {
        _csrfToken = generatedResponse['token'];
        sharedPreferences.setString('csrf_token', _csrfToken!['token']);
        sharedPreferences.setInt(
            'csrf_token_expiry', _csrfToken!['expiry'].millisecondsSinceEpoch);
      } else {
        throw Exception(
            'Failed to generate CSRF token:${generatedResponse['message']}');
      }
    }
    return _csrfToken!;
  }

  Future<Map<String, dynamic>> _generateCsrf() async {
    Dio apiClient = await instance.backendHelper;
    try {
      Response response = await apiClient.get("/sanctum/csrf-cookie");
      if (response.statusCode == 204) {
        List<String>? headerCookies = response.headers["set-cookie"];
        if (headerCookies != null && headerCookies.isNotEmpty) {
          var xsrfCookie = headerCookies
              .firstWhere((element) => element.contains('XSRF-TOKEN'));
          final cookieRegex = RegExp(r'XSRF-TOKEN=(.*?)%3D');
          final expiryRegex = RegExp(r'expires=(.*?)GMT;');
          String csrfToken = cookieRegex.firstMatch(xsrfCookie)!.group(1)!;
          DateTime expiry = DateFormat('EEE, d-MMM-yyyy HH:mm:ss')
              .parse(expiryRegex.firstMatch(xsrfCookie)!.group(1)!);
          return {
            "status": "success",
            "token": {
              'token': csrfToken,
              'expiry': expiry,
            },
          };
        } else {
          return {"status": "error", "message": "No CSRF token found"};
        }
      } else {
        return {"status": "error", "message": response.statusCode};
      }
    } catch (e) {
      return {
        "status": "Error",
        "message": e.toString(),
      };
    }
  }

  Future<String?> getuserToken() async {
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    if (sharedPreferences.getString("token") != null) {
      return sharedPreferences.getString("token")!;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> registerUser(
    String fullname,
    String email,
    String teamname,
    String password,
    String confirmPassword,
  ) async {
    Dio apiClient = await instance.backendHelper;
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    try {
      Response response = await apiClient.post("/api/register",
          data: {
            "name": fullname,
            "email": email,
            "teamname": teamname,
            "password": password,
            "password_confirmation": confirmPassword,
          },
          options: Options(
            headers: {
              'X-XSRF-TOKEN': (await _loadCsrf())['token'],
            },
          ));
      if (response.statusCode == 200) {
        sharedPreferences.setString("token", response.data['token']);
        return {"status": "success", "token": response.data};
      } else {
        return {"status": "error", "message": response.data['message']};
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return {
          "status": "error",
          "message": e.response?.data['message'],
          "errors": e.response?.data['errors']
        };
      } else {
        return {"status": "error", "message": e.message};
      }
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    Dio apiClient = await instance.backendHelper;
    try {
      Response response = await apiClient.post("/api/login",
          data: {
            "email": email,
            "password": password,
          },
          options: Options(
            headers: {
              'X-XSRF-TOKEN': (await _loadCsrf())['token'],
            },
          ));
      if (response.statusCode == 200) {
        sharedPreferences.setString("token", response.data['token']);
        return {"status": "success", "token": response.data['token']};
      } else {
        return {"status": "error", "message": response.data['message']};
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return {
          "status": "error",
          "message": e.response?.data['message'],
          "errors": e.response?.data['errors']
        };
      } else {
        return {"status": "error", "message": e.message};
      }
    }
  }

  Future<bool> logoutUser() async {
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    Dio apiClient = await instance.backendHelper;
    try {
      var response = await apiClient.post("/api/logout",
          options: Options(
            headers: {
              'X-XSRF-TOKEN': (await _loadCsrf())['token'],
              'Authorization': "Bearer ${await getuserToken()}",
            },
          ));
      if (response.statusCode == 200) {
        if (response.data['result'] == true) {
          sharedPreferences.remove("token");
          return true;
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        sharedPreferences.remove("token");
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<Map<String, dynamic>> makeRequest(String method, String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? query}) async {
    Dio apiClient = await instance.backendHelper;
    SharedPreferences sharedPreferences = await instance.sharedPreferences;
    try {
      Response response;
      if (method == "get") {
        response = await apiClient.get(url,
            queryParameters: query,
            options: Options(
              headers: {
                'X-XSRF-TOKEN': (await _loadCsrf())['token'],
                'Authorization': "Bearer ${await getuserToken()}",
              },
            ));
      } else if (method == "post") {
        response = await apiClient.post(url,
            data: body,
            options: Options(
              headers: {
                'X-XSRF-TOKEN': (await _loadCsrf())['token'],
                'Authorization': "Bearer ${await getuserToken()}",
              },
            ));
      } else if (method == "put") {
        response = await apiClient.put(url,
            data: body,
            options: Options(
              headers: {
                'X-XSRF-TOKEN': (await _loadCsrf())['token'],
                'Authorization': "Bearer ${await getuserToken()}",
              },
            ));
      } else {
        response = await apiClient.delete(url,
            options: Options(
              headers: {
                'X-XSRF-TOKEN': (await _loadCsrf())['token'],
                'Authorization': "Bearer ${await getuserToken()}",
              },
            ));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "status": response.data['status'],
          "data": response.data['data']
        };
      } else {
        return {"status": "error", "message": response.data['message']};
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        sharedPreferences.remove("token");
        return {"status": HttpStatus.unauthorized, "message": "Unauthorized"};
      } else if (e.response?.statusCode == 422) {
        return {
          "status": "validation",
          "message": e.response?.data['message'],
          "errors": e.response?.data['errors']
        };
      } else {
        return {"status": "error", "message": e.message};
      }
    }
  }
}
