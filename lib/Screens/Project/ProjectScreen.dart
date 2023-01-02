import 'package:flutter/material.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';

import 'package:projectshub1/Screens/Project/components.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Classes/Project.dart';

class ProjectScreen extends StatelessWidget {
  //const ProjectScreen({Key? key}) : super(key: key);
  Project curr_project;

  ProjectScreen(this.curr_project);

  Widget showAllPositions(Project curr_project) {
    List<Widget> memberWidgets = [];
    for (var i in curr_project.member_role) {
      print("image : ${i['Profile_image']}");
      memberWidgets
          .add(ProjectMember(i['First_name'], i['Profile_image'], i['Role']));
    }
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: memberWidgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //Map<String, String> memberRole = curr_project.member_role
    //  .map((key, value) => MapEntry(key.First_name, value));

    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SlidingUpPanel(
        minHeight: screenHeight * 0.7,
        maxHeight: screenHeight * 0.8,
        body: buildTop(),
        panelBuilder: (controller) => buildHeader(controller, curr_project),
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget buildTop() {
    return Stack(children: [
      Container(
        child: Image.asset("assets/images/ZCSF2.jpg"),
      ),
    ]);
  }

  Widget buildHeader(ScrollController cont, Project u) {
    return ListView(
      controller: cont,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 0, left: 20, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                u.P_title,
                style: TextStyle(
                  fontFamily: 'san fran',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    u.P_description,
                    style: TextStyle(
                      fontFamily: 'san fran',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                child: heading1_text('Position Needed'),
                alignment: Alignment.centerLeft,
              ),
              Column(
                children: [
                  for (var i in curr_project.positions_needed) PositionNeeded(i)
                ],
              ),
              Align(
                child: heading1_text('Members'),
                alignment: Alignment.centerLeft,
              ),
              showAllPositions(curr_project),
              //Block('Contact', [u.Email_address]),
              //Block('Skills', u.skills),
            ],
          ),
        ),
      ],
    );
  }
}
