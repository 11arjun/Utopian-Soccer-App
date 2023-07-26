// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:utopiansoccer/Tabs/soccermodel.dart';

class SoccerApi {
  //now lets set our variables
  // first lest add the endpoint URL
  // we will get all the data from api-sport.io
  final Uri apiUrl =
      Uri.parse("https://v3.football.api-sports.io/fixtures?live=all");
  // In  this we will only see how to get the live matches news
  //now lets add the headers
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    // always make sure the api key and the limit of a request in a free api
    'x-rapidapi-key': "fd478d8471d03cf3aefe5b1fd2c03cac",
    //  "fd478d8471d03cf3aefe5b1fd2c03cac",
  };
  //now we  will create  our method
  // but before this we  need to create our models

  //Now we finished with our model
  Future<List<SoccerMatch>> getAllMatches() async {
    Response res = await get(apiUrl, headers: headers);
    late Map<String, dynamic> body;

    if (res.statusCode == 200) {
      // this means that we are connected to the data base
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service : $body"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    } else {
      throw Exception(res.statusCode);
    }
  }
}
