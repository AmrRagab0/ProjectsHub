import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Screens/HomeScreen/HomeScreen.dart';
import 'package:projectshub1/Screens/Welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var user = null;
    final user = Provider.of<Student?>(
        context); // specifying the type of stream(student) , every time the stream changes we create the var user
    //print(user);

    if (user == null) {
      return WelcomeScreen();
    } else {
      return HomeScreen();
    }
  }
}
