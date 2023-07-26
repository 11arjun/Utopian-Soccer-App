// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:utopiansoccer/Tabs/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget textfield({required String hinText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hinText,
          hintStyle: const TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white54,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 11),
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 122, 73, 131),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(""),
                    ),
                  ),
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textfield(
                        hinText: 'Arjun Shrestha',
                      ),
                      textfield(
                        hinText: 'alexizshrestha11@gmail.com',
                      ),
                      textfield(
                        hinText: '9803286585',
                      ),
                      textfield(
                        hinText: 'Arjun and his company',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomPaint(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 5,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 290, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const EditProfile()),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends Profile {
  const HeaderCurvedContainer({Key? key}) : super(key: key);

  blank(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 15)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
