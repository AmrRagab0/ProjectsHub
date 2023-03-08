import 'package:flutter/material.dart';

//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';
//import 'package:projectshub1/Screens/HomeScreen/Components/Project_card.dart';

import 'package:projectshub1/Screens/Project/components.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Classes/Project.dart';

enum Menuvalues {
  deleteProject,
}

class AdminProjectScreen extends StatefulWidget {
  //const AdminProjectScreen({Key? key}) : super(key: key);
  Project curr_project;

  AdminProjectScreen(this.curr_project);

  @override
  State<AdminProjectScreen> createState() => _AdminProjectScreenState();
}

class _AdminProjectScreenState extends State<AdminProjectScreen> {
  TextEditingController _descriptionController = new TextEditingController();

  Widget showAllmembers(Project curr_project) {
    List<Widget> memberWidgets = [];
    for (var i in curr_project.member_role) {
      //print("image : ${i['Profile_image']}");
      memberWidgets.add(ProjectMember(
          i['First_name'], i['uid'], i['Profile_image'], i['Role'], context));
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
    _descriptionController.text = widget.curr_project.P_description;
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<Menuvalues>(
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text("Delete Project"),
                          ],
                        ),
                      ),
                      value: Menuvalues.deleteProject,
                    ),
                  ]),
              onSelected: ((value) {
                switch (value) {
                  case Menuvalues.deleteProject:
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text('Delete Project ?'),
                            content: Text(
                                'Are you sure you want to delete this project ?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    DatabseService(
                                            P_uid: widget.curr_project.pid)
                                        .deleteProject(widget.curr_project.pid);
                                    print('deleted');
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                            ],
                          );
                        }));
                }
              })),
        ],
      ),
      body: SlidingUpPanel(
        minHeight: screenHeight * 0.7,
        maxHeight: screenHeight * 0.8,
        body: buildTop(widget.curr_project),
        panelBuilder: (controller) =>
            buildHeader(controller, widget.curr_project),
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
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
                children: [
                  for (var i in widget.curr_project.positions_needed)
                    adminPositionsNeeded(i, 'View Applicants')
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


/*
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
      */