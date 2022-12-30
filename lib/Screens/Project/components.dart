import 'dart:ffi';

import 'package:flutter/material.dart';

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

Widget heading1_text(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'san fran',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget profilePicture(imagePath) {
  return CircleAvatar(
    radius: 20,
    child: ClipOval(
      child: Image.asset(imagePath),
    ),
  );
}

Widget PositionNeeded(String positionName) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 15,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          positionName,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 150,
        ),
        roundedButton(),
      ],
    ),
  );
}

Widget roundedButton() {
  return SizedBox(
    height: 30,
    width: 70,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.blueAccent)))),
      child: Text(
        'Apply',
        style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'san fran',
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget ProjectMember(String name, String PositionName) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage('assets/images/profiles/Hashem.jpg'),
        ),
        SizedBox(
          width: 9,
        ),
        MemberText(name),
        SizedBox(
          width: 87,
        ),
        MemberPosition(PositionName),
      ],
    ),
  );
}

Widget MemberText(String text) {
  return Text(text,
      style: TextStyle(
        fontFamily: 'san fran',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ));
}

Widget MemberPosition(String text) {
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15)),
    //color: Colors.black,
    child: MemberText(text),
  );
}
