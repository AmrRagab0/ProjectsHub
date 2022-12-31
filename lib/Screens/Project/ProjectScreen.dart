import 'package:flutter/material.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';

import 'package:projectshub1/Screens/Project/components.dart';

import '../../Classes/Project.dart';

class ProjectScreen extends StatelessWidget {
  //const ProjectScreen({Key? key}) : super(key: key);
  Project curr_project;

  ProjectScreen(this.curr_project);

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
          title: heading1_text(curr_project.P_title),
        ),
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              //color: Colors.black,
              alignment: Alignment.bottomLeft,
              child: heading1_text(curr_project.P_title),
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
                  normal_text(curr_project.P_description),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: heading2_text('Needed Positions')),
                  Column(
                    children: [
                      for (var i in curr_project.positions_needed)
                        PositionNeeded(curr_project.positions_needed.toString())
                    ],
                  ),
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
