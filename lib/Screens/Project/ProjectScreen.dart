import 'package:flutter/material.dart';

import 'package:projectshub1/Screens/Project/components.dart';

class ProjectScreen extends StatelessWidget {
  //const ProjectScreen({Key? key}) : super(key: key);
  String ProjectName = 'ZCSF';
  String Description =
      'Zewail city science festival is an event about explaining science concepts in a simple way for every one , every background. the event is bla bla bla ';
  List positionS = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ZCSF2.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.black,
          title: heading1_text(ProjectName),
        ),
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              //color: Colors.black,
              alignment: Alignment.bottomLeft,
              child: heading1_text(ProjectName),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: heading2_text(
                      'Description',
                    ),
                  ),
                  normal_text(Description),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: heading2_text('Needed Positions')),
                  PositionNeeded('App developer'),
                  PositionNeeded('App developer'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: heading2_text(
                      'Members',
                    ),
                  ),
                  ProjectMember('Mohamed Hashem', 'PR Member'),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
