import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import './components.dart';

class NotifItem extends StatefulWidget {
  const NotifItem({Key? key}) : super(key: key);

  @override
  State<NotifItem> createState() => _NotifItemState();
}

class _NotifItemState extends State<NotifItem> {
  final img_path = 'assets/images/profiles/MH.jpg';
  final String message =
      "Folan el folany accepted your request to join Project as kaza kaza";
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListTile(
          onTap: () {},
          enabled: true,
          leading: Container(
            padding: EdgeInsets.all(5),
            height: 60,
            child: profilePicture(img_path),
          ),
          //title: Text(
          //"Project Name",
          //style: TextStyle(fontFamily: 'san fran', fontWeight: FontWeight.bold),
          //),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "This is  bold text. ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "This is some italic text. ",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: "This is some red text. ",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          )),
    );
  }
}





/*
Row(
      children: [
        profilePicture(img_path),
        Flexible(
          child: normal_text(message),
        ),
      ],
    )
    */ 
