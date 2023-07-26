// ignore_for_file: unnecessary_new, deprecated_member_use, duplicate_ignore, unused_local_variable, sized_box_for_whitespace

// ignore: unused_import
// import 'dart:html';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:utopiansoccer/main.dart';

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List names = [
    "Utopain KIEC",
    "Young Boys",
    "Hardy Boys",
    " Boys United ",
    "AYC"
  ];
  List designations = [
    "Sinamangal",
    "Baluwatar",
    "Pokhara",
    "Lamjung",
    "Maitidevi",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Team Lists",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 55.0,
                        height: 55.0,
                        child: const CircleAvatar(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.green,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlC-DDwOftK7jPoJEMzmYdxk-qEBJwlSvDAw&usqp=CAU'),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            names[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            designations[index],
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: FlatButton(
                      onPressed: () {
                        openDialog();
                      },
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: ((context) => MyAlert()),
                      //     ),
                      //   );
                      // },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        "Challenge",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Why do you want to challenge?'),
          content: const TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter here"),
          ),
          actions: [
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                showGeneralDialog(
                    barrierLabel: 'label',
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(0, 1),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                    pageBuilder: (context, anim1, anim2) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 500,
                          width: 350,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Material(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox.shrink(),
                                      IconButton(
                                          icon: const Icon(Icons.cancel),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/images/success.gif',
                                    height: 200,
                                  ),
                                  const Text(
                                    'Success',
                                    style: TextStyle(
                                      color: Color(0xff81cffc),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const Text(
                                    ' Successfully Challenged',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 235,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xff81cffc),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                'Ok Let\'s  Battle !',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      );
  // void submit() {
  //   return Navigator.of(context).pop(displayDialog);
  // }

  displayDialog() {
    // const AlertDialog(
    //   title: Text("Confirmation"),
    //   content: Text("Are you sure"),
    //   // actions: [
    //   //   CupertinoDialogAction("yes"),
    //   //   CupertinoDialogAction("No"),
    //   // ],
    //   elevation: 24.0,
    //   backgroundColor: Colors.green,
    //   shape: CircleBorder(),
    // );
  }

  _displayDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure ?'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              new FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: ((context) => const Teams()),
                  //   ),
                  // );
                },
              )
            ],
          );
        });
  }
}
