import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:projectshub1/Screens/Login/login.dart';
import 'package:projectshub1/Screens/Sign%20Up/SignUp_Screen.dart';
import 'package:projectshub1/Services/auth.dart';
import '../../../animation/loading.dart';

import 'RoundedButton.dart';
import 'background.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();

  bool is_loading = false;

  // sign in with google
  final GoogleSignIn _G_signin = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return is_loading
        ? Loading()
        : Background(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Welcome to Projects Hub",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 60,
                    width: 20,
                  ),
                  Image.asset(
                    'assets/images/Logo.png',
                    height: size.height * 0.3,
                  ),
                  SizedBox(
                    height: 60,
                    width: 20,
                  ),
                  // SvgPicture.asset(
                  //   'assets/icons/Rectangle 157.svg',
                  //   height: size.height * 0.4,
                  // ),
                  RoundButton(
                    text: 'Login',
                    press: () async {
                      try {
                        final userCredential = await _auth.signInWithGoogle();
                        print('User signed in successfully!');
                        // Do something with the userCredential, e.g. navigate to a new screen
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-not-allowed') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Sign-in Error'),
                              content: Text('Please sign in with a ZC email.'),
                            ),
                          );
                        } else {
                          // Handle other sign-in errors
                          print('Error occurred while signing in: $e');
                        }
                      } catch (e) {
                        // Handle other errors
                        print('Error occurred while signing in: $e');
                      }
                    },
                    color: Colors.black,
                    textcolor: Colors.white,
                  ),

                  /*
                  // old login button
                  RoundButton(
                    text: 'Login',
                    press: () async {
                      dynamic result = await _auth.signInWithGoogle();

                      setState(() {
                        is_loading = true;
                      });

                      if (result == null) {
                        setState(() {
                          is_loading = false;
                        });
                      }
                    },
                    color: Colors.black,
                    textcolor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  RoundButton(
                    text: 'Sign Up',
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                    color: Colors.grey.shade300,
                    textcolor: Colors.black,
                  ),
                  
                  SizedBox(
                    height: 40,
                  ),
                  PressableSmallButton(
                    text: 'Use as a guest',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("البيت بيتك"),
                            content: Text(
                                'عيب يسطا والله انت مش ضيف...ادخل بايميلك يا صاحبي'),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.black45,
                    textcolor: Colors.black,
                  )
                  */
                ],
              ),
            ),
          );
  }
}
