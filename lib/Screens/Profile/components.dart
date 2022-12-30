import 'package:flutter/material.dart';

Widget heading2_text(String text) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'san fran',
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget heading1_text({required String text, c = Colors.black}) {
  return Padding(
    padding: EdgeInsets.only(left: 20, bottom: 5, right: 5, top: 5),
    child: Text(
      text,
      style: TextStyle(
        color: c,
        fontFamily: 'san fran',
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget normal_text(String text) {
  return Padding(
    padding: EdgeInsets.all(4),
    child: Text(
      text,
      style: TextStyle(
          fontFamily: 'san fran',
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.black),
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

Widget _oneSkill(String skill) {
  return Container(
    padding: EdgeInsets.only(left: 18, right: 5, top: 5, bottom: 5),
    child: Row(
      children: [
        Icon(
          Icons.radio_button_checked,
          size: 15,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          skill,
          style: TextStyle(
              fontFamily: 'san fran',
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
