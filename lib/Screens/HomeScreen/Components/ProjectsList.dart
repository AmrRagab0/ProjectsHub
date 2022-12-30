import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/foundation/key.dart';

import 'Project_card.dart';

import 'package:projectshub1/Classes/Project.dart';

import 'package:provider/provider.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final All_projects = Provider.of<List<Project>>(context);

    All_projects.sort((a, b) => a.created_on.compareTo(b.created_on));
    //print('all projects:${All_projects}');

    return ListView.builder(
      itemBuilder: (context, index) {
        return Project_card(theProject: All_projects[index]);
      },
      itemCount: All_projects.length,
    );
  }
}
