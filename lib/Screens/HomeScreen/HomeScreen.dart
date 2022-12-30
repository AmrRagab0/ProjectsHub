//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/Project.dart';
import 'package:projectshub1/Screens/HomeScreen/Components/ProjectsList.dart';
import 'package:projectshub1/Screens/Menu/Menu.dart';
import 'package:projectshub1/Screens/New%20Project/NewProjectScreen.dart';
import 'package:projectshub1/Screens/Profile/ProfileScreen.dart';
import 'package:projectshub1/Screens/Profile/profile.dart';
import 'package:projectshub1/Screens/Project/ProjectScreen.dart';
import 'Components/Project_card.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:flutter_launcher_icons/';
import '../../Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({Key? key}) : super(key: key);
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final all_projects = Provider.of<List<Project>>(context);

    return StreamProvider<List<Project>>.value(
      value: DatabseService().projectStream,
      initialData: [],
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: GNav(
              selectedIndex: current_index,
              onTabChange: (index) => current_index = index,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.lightbulb_outline,
                  text: "My Projects",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext Context) => ProjectScreen(),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: Icons.circle_notifications,
                  text: 'Notifications',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext Context) => Menu(),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: "Profile",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext Context) => ProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext Context) => NewProjectScreen(),
              ),
            );
          },
          backgroundColor: Colors.black,
          label: Text(
            'New Project',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: ProjectList(),
          ),
          //child: Center(),
/*
          child: Center(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Project_card(
                theProject: all_projects[index],
              );
            },
            itemCount: all_projects.length,
          )
              
              Container(
              //height: size.height * 0.3,
              width: size.width * 0.95,
              child: Column(
                children: [
                  Project_card(
                    ImageName: 'ZCSF2.jpg',
                    P_title: "ZCSF",
                    position1: 'App developer',
                    //position2: 'Fund Raising',
                  ),
                  Project_card(
                    position1: 'PR member',
                    position2: 'coder',
                    P_title: 'IEEE project',
                  ),
                  Project_card(
                    P_title: 'ZC OCW',
                    ImageName: 'ZCOCW.jpg',
                    position1: 'Video Editor',
                    position2: 'Camera man',
                    position3: 'Social media admin',
                  ),
                  Project_card(
                    P_title: 'Science Youtube Channel',
                    position1: 'SEO optimizer',
                  ),
                  Project_card(
                    P_title: 'Mobile Application',
                    position1: 'Front-End developer',
                    position2: 'Back-End developer',
                    ImageName: 'Mobile App.png',
                  ),
                ],
              ),
            ),*/
        ),
      ),
    );
  }
}
