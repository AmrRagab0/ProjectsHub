import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../Screens/Project/AdminProjectScreen.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:provider/provider.dart';
import '../../Classes/Student.dart';
import '../../Classes/Project.dart';
import '../HomeScreen/Components/Project_card.dart';

class MyProjectsList extends StatefulWidget {
  const MyProjectsList({Key? key}) : super(key: key);

  @override
  State<MyProjectsList> createState() => _MyProjectsListState();
}

class _MyProjectsListState extends State<MyProjectsList> {
  @override
  Widget build(BuildContext context) {
    final All_projects = Provider.of<List<Project>>(context);

    All_projects.sort((a, b) => a.created_on.compareTo(b.created_on));
    List<Project> MyProjects = [];
    final user = Provider.of<Student?>(context);

    return StreamBuilder<Student>(
      stream: DatabseService(St_uid: user!.uid).studentStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Student me = snapshot.data!;
          for (var p in All_projects) {
            //print('comparing ${me.current_projects} and ${p.pid}');
            if (me.current_projects.contains(p.pid)) {
              if (MyProjects.contains(p) != true) {
                MyProjects.add(p);
                //print('added');
              }
            }
          }

          MyProjects.toList().toSet();
          //print('current :${MyProjects}');
          return ListView.builder(
            itemBuilder: (context, index) {
              return Project_card(theProject: MyProjects[index]);
            },
            itemCount: MyProjects.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
