import 'package:flutter/material.dart';
import 'Student.dart';

class Project {
  String P_title = "";
  String uid = "";
  String P_description = "";
  int? num_members = 1;
  List<dynamic> positions_needed;
  //List<Student>? p_members;
  Map<String, dynamic> member_role = {};
  String imageName = "Default.jpg";
  DateTime created_on = DateTime.now();
  String p_owner;

  Project(
      {required this.P_title,
      required this.P_description,
      required this.positions_needed,
      required this.p_owner,
      required this.member_role});

  // add position to positions list
  void _addposition(String position_name) {
    if (position_name != null) {
      this.positions_needed.add(position_name);
      //print('positions list ${positions_needed}');
    }
  }

  // add student to project
  void addStudent(String s, String role) {
    member_role[s] = role;
    print('type is :${member_role[s].runtimeType}');
  }

  // remove student to project

  // Store project in firestore
  Map saveProjectDb(Project p) {
    final save_out = {
      'uid': p.uid,
      'name': p.P_title,
      'description': p.P_description,
      'positions_needed': p.positions_needed,
      'Project Owner': p.p_owner,
      'created on': p.created_on,
      'member-role': p.member_role,
    };
    return save_out;
  }
}
