import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/Welcome/welcome_screen.dart';
import '../Welcome/Components/RoundedButton.dart';
import '../../Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:projectshub1/Classes/Student.dart';

class Menu extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Projects Hub",
            style: TextStyle(
              fontFamily: 'san fran',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'san fran',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: RoundButton(
                  text: 'Sign out',
                  press: () async {
                    await _auth.signOut();
                    await FirebaseAuth.instance.signOut();
                  },
                  color: Colors.black,
                  textcolor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
