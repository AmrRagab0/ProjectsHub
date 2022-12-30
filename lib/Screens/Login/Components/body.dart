// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/HomeScreen/HomeScreen.dart';
import 'package:projectshub1/Screens/Login/Components/Background.dart';
import 'package:projectshub1/Screens/Login/login.dart';
import 'package:projectshub1/Screens/Sign%20Up/SignUp_Screen.dart';
import 'package:projectshub1/Screens/Welcome/Components/RoundedButton.dart';
import 'package:projectshub1/Screens/Login/Components/AlreadyHaveAnAccount.dart';
import 'package:projectshub1/Services/auth.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // holds the state of the form

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
                width: 20,
              ),
              Image.asset(
                'assets/images/Logo.png',
                height: size.height * 0.22,
              ),
              SizedBox(
                height: 40,
                width: 20,
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
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: "your Email",
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
                      Icons.lock,
                      color: Colors.black,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              RoundButton(
                  text: 'Sign in',
                  press: () async {
                    if (_formKey.currentState!.validate()) {}
                    print(email);
                    print(password);
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                    */
                  },
                  color: Colors.black,
                  textcolor: Colors.white),
              SizedBox(height: 10.0),
              HaveAnAccount(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Color(0xFFbdc6cf), borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
