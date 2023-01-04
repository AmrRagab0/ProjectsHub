import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectshub1/Classes/Project.dart';

import '../../Classes/Student.dart';
import '../HomeScreen/Components/Project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    final All_projects = Provider.of<List<Project>>(context);
    final user = Provider.of<Student?>(context);
    final List<String> MyProjects_ids = user!.current_projects;

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Project_card(theProject: All_projects[index]);
        },
        itemCount: All_projects.length,
      ),
    );
  }
}
