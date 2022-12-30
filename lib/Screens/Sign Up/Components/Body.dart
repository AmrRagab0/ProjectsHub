// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/Login/Components/body.dart';
import 'package:projectshub1/Screens/Login/login.dart';
import 'package:projectshub1/Screens/Sign%20Up/Components/Background.dart';
import 'package:projectshub1/Screens/Sign%20Up/Components/OR_Divider.dart';
import 'package:projectshub1/Screens/Welcome/Components/RoundedButton.dart';
import 'package:projectshub1/Screens/Sign Up/Components/Social_icon.dart';
import 'package:projectshub1/Services/auth.dart';

import '../../Login/Components/AlreadyHaveAnAccount.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '';
  String password = '';

  String error = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Image.asset(
              "assets/images/Logo.png",
              width: size.width * 0.7,
              height: size.height * 0.15,
            ),
            TextFieldContainer(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Username",
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                validator: (val) {
                  // returns null if everything is ok, helper text if something is wrong
                  if (val != null && val.isEmpty) {
                    return 'Email Cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                obscureText: true, // adds stars instead of letters
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                validator: (val) {
                  if (val != null && val.length < 8) {
                    return 'password must be at least 8 characters';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            RoundButton(
                text: 'Sign Up',
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.Register(email, password);

                    if (result != null) {
                      Navigator.pop(
                          context); // goes to home screen...don't know how ?
                    } else {}
                  }
                },
                color: Colors.black,
                textcolor: Colors.white),
            SizedBox(height: 10.0),
            HaveAnAccount(
              press: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                */
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(iconSrc: 'assets/images/search.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
