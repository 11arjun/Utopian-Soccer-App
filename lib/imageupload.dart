import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Service extends StatefulWidget {
  Service({Key? key}) : super(key: key);

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  late File file;
  Future pickercamera() async {
    // ignore: deprecated_member_use
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      // file = File(myfile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: const Text("upload Image"),
            onPressed: pickercamera,
          )
        ],
      ),
    );
  }
}
