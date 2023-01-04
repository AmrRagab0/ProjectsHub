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
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Projects Hub",
                style: TextStyle(
                  fontFamily: 'san fran',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate([]));
                  },
                  icon: Icon(Icons.search))
            ],
            backgroundColor: Colors.black,
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
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Project> All_projects;

  CustomSearchDelegate(this.All_projects);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var project in All_projects) {
      if (project.P_title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(project);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return Project_card(theProject: matchQuery[index]);
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var project in All_projects) {
      if (project.P_title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(project);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return Project_card(theProject: matchQuery[index]);
      },
      itemCount: matchQuery.length,
    );
  }
}
