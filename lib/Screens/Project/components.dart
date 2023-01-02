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
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
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
    padding: EdgeInsets.only(top: 5, bottom: 5),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          positionName,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: SizedBox(),
        ),
        roundedButton(),
      ],
    ),
  );
}

Widget roundedButton() {
  return SizedBox(
    height: 35,
    width: 80,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 10, 51, 121)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromARGB(255, 10, 51, 121))))),
      child: Text(
        'Apply',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'san fran',
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget ProjectMember(String name, String img_url, String PositionName) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(img_url),
        ),
        SizedBox(
          width: 9,
        ),
        MemberText(name),
        Expanded(child: SizedBox()),
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

/*
Widget Block(String header, List<String> items) {
  List<Widget> list = [];
  for (var i = 0; i < items.length; i++) {
    list.add(heading2_text(items[i]));
  }
  return Container(
    padding: EdgeInsets.all(5),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: heading1_text(text: header),
        ),
        Column(
          children: [for (var i in items) _oneSkill(i)],
        )
      ],
    ),
  );
}
*/
