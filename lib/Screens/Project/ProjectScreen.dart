import 'package:flutter/material.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';

import 'package:projectshub1/Screens/Project/components.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import '../../Classes/Project.dart';
import '../../Classes/Student.dart';
import '../../Services/database.dart';

class ProjectScreen extends StatefulWidget {
  //const ProjectScreen({Key? key}) : super(key: key);
  Project curr_project;

  ProjectScreen(this.curr_project);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  Widget showAllmembers(Project curr_project) {
    List<Widget> memberWidgets = [];
    for (var i in curr_project.member_role) {
      //print("image : ${i['Profile_image']}");
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

  void apply_process() {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //Map<String, String> memberRole = curr_project.member_role
    //  .map((key, value) => MapEntry(key.First_name, value));
    final user = Provider.of<Student?>(context);
    return StreamBuilder<Student>(
        stream: DatabseService(St_uid: user!.uid).studentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Student me = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text('Project Details'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: SlidingUpPanel(
                minHeight: screenHeight * 0.7,
                maxHeight: screenHeight * 0.8,
                body: buildTop(widget.curr_project),
                panelBuilder: (controller) =>
                    buildHeader(controller, widget.curr_project, me),
                parallaxEnabled: true,
                parallaxOffset: 0.5,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget buildTop(Project u) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 170,
        alignment: Alignment.center,
        child: Text(
          "",
          style: TextStyle(
              fontFamily: 'san fran',
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white),
        ),
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(u.P_image), fit: BoxFit.fill),
        ),
      ),
    ]);
  }

  Widget buildHeader(ScrollController cont, Project u, Student st) {
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
              SizedBox(
                height: 10,
              ),
              Align(
                child: heading1_text('Description'),
                alignment: Alignment.centerLeft,
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
                children: widget.curr_project.positions_needed.isNotEmpty
                    ? [
                        for (var i in widget.curr_project.positions_needed)
                          PositionNeeded(
                              i, 'Apply', st, u.pid, u.P_title, u.p_owner),
                      ]
                    : [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 10),
                          child: Center(
                            child: normal_text(
                              'This project has no vacant postions.',
                            ),
                          ),
                        ),
                      ],
              ),
              Align(
                child: heading1_text('Members'),
                alignment: Alignment.centerLeft,
              ),
              showAllmembers(widget.curr_project),
              //Block('Contact', [u.Email_address]),
              //Block('Skills', u.skills),
            ],
          ),
        ),
      ],
    );
  }
}
