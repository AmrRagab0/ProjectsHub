import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/MyProjects/MyProjectsList.dart';
import 'package:provider/provider.dart';
import 'package:projectshub1/Classes/Project.dart';

import '../../Classes/Student.dart';
import '../../Services/database.dart';
import '../HomeScreen/Components/Project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamProvider<List<Project>>.value(
      value: DatabseService().projectStream,
      initialData: [],
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
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: MyProjectsList(),
          ),
        ),
      ),
    );
  }
}
