import 'package:flutter/material.dart';
import 'Student.dart';

class Project {
  String P_title = "";
  String uid = "";
  String P_description = "";
  int? num_members = 1;
  List<dynamic> positions_needed;
  //List<Student>? p_members;
  late Map<Student, String> member_role;
  String imageName = "Default.jpg";
  DateTime created_on = DateTime.now();
  String can_edit;

  Project(
      {required this.P_title,
      required this.P_description,
      required this.positions_needed,
      required this.can_edit});

  // add position to positions list
  void _addposition(String position_name) {
    if (position_name != null) {
      this.positions_needed?.add(position_name);
      //print('positions list ${positions_needed}');
    }
  }

  // add student to project

  // remove student to project

  // Store project in firestore
  Map saveProjectDb(Project p) {
    final save_out = {
      'uid': p.uid,
      'name': p.P_title,
      'description': p.P_description,
      'positions_needed': p.positions_needed,
      'can edit': p.can_edit,
      'created on': p.created_on
    };
    return save_out;
  }
}
