import 'package:flutter/material.dart';

Widget profilePicture(imagePath) {
  return CircleAvatar(
    radius: 30,
    child: ClipOval(
      child: Image.asset(imagePath),
    ),
  );
}

Widget heading1_text(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'san fran',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

Widget normal_text(String text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: 'san fran',
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black),
  );
}

Widget heading2_text(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'san fran',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
