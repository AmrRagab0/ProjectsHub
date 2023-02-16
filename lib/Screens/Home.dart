import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/Project.dart';
import 'package:projectshub1/Screens/HomeScreen/Components/ProjectsList.dart';
import 'package:projectshub1/Screens/HomeScreen/HomeScreen.dart';
import 'package:projectshub1/Screens/Menu/Menu.dart';
import 'package:projectshub1/Screens/MyProjects/MyProjects.dart';
import 'package:projectshub1/Screens/New%20Project/NewProjectScreen.dart';
import 'package:projectshub1/Screens/Notifications/NotificationsScreen.dart';
import 'package:projectshub1/Screens/Profile/ProfileScreen.dart';
import 'package:projectshub1/Screens/Profile/editProfile.dart';
import 'package:projectshub1/Screens/Profile/profile.dart';
import 'package:projectshub1/Screens/Project/ProjectScreen.dart';
//import 'Components/Project_card.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:flutter_launcher_icons/';
import '../../Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current_index = 0;

  final screens = [
    HomeScreen(),
    //ProjectScreen(Project ),
    MyProjects(),
    NotificationsScreen(),
    editProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[current_index],
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
            onTabChange: (index) => setState(() {
              current_index = index;
            }),
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
                onPressed: () {},
              ),
              GButton(
                icon: Icons.circle_notifications,
                text: 'Notifications',
                onPressed: () {},
              ),
              GButton(
                icon: Icons.person_outline,
                text: "Profile",
                onPressed: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext Context) => screens[current_index],
                    ),
                  );
                  */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
