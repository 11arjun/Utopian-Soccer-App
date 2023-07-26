import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utopiansoccer/utils/backend_helper.dart';
import 'package:utopiansoccer/utils/url_helper.dart';

import '../booking_confirmation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Fields",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: FutureBuilder(
        future: getFutsalVenues(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List futsalVenues = snapshot.data;
            return ListView.builder(
              itemCount: futsalVenues.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Colors.purple,
                      elevation: 14.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 120.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image(
                                image: NetworkImage(
                                    backendUrl + futsalVenues[index]['image']),
                                fit: BoxFit.cover,
                                alignment: Alignment.topRight,
                              ),
                            ),
                          ),

                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    futsalVenues[index]['name'],
                                    style: const TextStyle(
                                        color: Colors.purple,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: const <Widget>[
                                      // ignore: avoid_unnecessary_containers

                                      // ignore: avoid_unnecessary_containers
                                    ],
                                  ),
                                  // ignore: avoid_unnecessary_containers
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => Confirmation(
                                                productData:
                                                    futsalVenues[index],
                                              )),
                                        ),
                                      );
                                    },
                                    child: const Text('BookNow'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error Occurred"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List> getFutsalVenues() async {
    Dio dio = Dio();
    var response =
        await BackendHelper.instance.makeRequest("get", "/api/venues");
    return response['data'];
  }
}
