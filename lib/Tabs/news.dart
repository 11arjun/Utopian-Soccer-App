import 'package:flutter/material.dart';
import 'package:utopiansoccer/Tabs/api_manager.dart';
import 'package:utopiansoccer/Tabs/pagerbody.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafaafa),
      appBar: AppBar(
        backgroundColor: const Color(0xffafaafa),
        elevation: 0.0,
        title: const Text(
          "Live Soccer News",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      // Now before we create our layout let's create our API service.
      body: FutureBuilder<Iterable>(
        future: SoccerApi()
            .getAllMatches(), //here we will call our getData() method,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data).length);
            return pageBody(snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }, // here will build our app layout
      ),
    );
  }
}
