import 'package:flutter/material.dart';
import 'package:utopiansoccer/background.dart';
// ignore: unused_import
import 'package:utopiansoccer/images.dart';
import 'package:utopiansoccer/signup.dart';
import 'login.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides us total height and width of our screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Welcome To Utopian Soccer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Canterbury',
                color: Colors.green,
              )),
          // const SizedBox(
          //   height: 22,
          // ),
          // ignore: unnecessary_const
          Image.asset(
            "assets/images/kick.jpeg",
          ),
          const SizedBox(
            height: 11,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              // ignore: deprecated_member_use
              child: FlatButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: const Color.fromARGB(255, 111, 204, 4),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Login()),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          SizedBox(
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              // ignore: deprecated_member_use
              child: FlatButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: const Color.fromARGB(255, 151, 164, 135),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Signup()),
                    ),
                  );
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
