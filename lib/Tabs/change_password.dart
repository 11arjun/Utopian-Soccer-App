// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _ProfileState();
}

class _ProfileState extends State<Password> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  onPasswordChanged(String password) {
    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;
    });
    setState(() {
      _hasPasswordOneNumber = false;
      if (password.length >= 8) _hasPasswordOneNumber = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set a new password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.green,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Change password",
              // ignore: unnecessary_const
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Please create a  new  secure password including the following criteria below",
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              onChanged: (password) => onPasswordChanged(password),
              obscureText: !_isVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Old Password",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            ),
            const SizedBox(
              height: 7,
            ),
            TextField(
              obscureText: !_isVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "New Password",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            ),
            const SizedBox(
              height: 11,
            ),
            TextField(
              obscureText: !_isVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  hintText: "Confirm Password",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: _isPasswordEightCharacters
                          ? Colors.green
                          : Colors.transparent,
                      border: _isPasswordEightCharacters
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("contains at least  8 characters")
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: _hasPasswordOneNumber
                          ? Colors.green
                          : Colors.transparent,
                      border: _hasPasswordOneNumber
                          ? Border.all(color: Colors.transparent)
                          : Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 11,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Contains at least 1 number"),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            MaterialButton(
              height: 40,
              minWidth: double.infinity,
              onPressed: () {},
              color: Colors.green,
              child: const Text(
                "Change Password",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            )
          ],
        ),
      ),
    );
  }
}
