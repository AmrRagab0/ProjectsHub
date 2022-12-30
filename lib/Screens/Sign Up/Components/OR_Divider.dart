// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          BuildDivider(),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
          BuildDivider()
        ],
      ),
    );
  }

  Expanded BuildDivider() {
    return Expanded(
      child: Divider(
        color: Colors.black,
        height: 1.5,
      ),
    );
  }
}
