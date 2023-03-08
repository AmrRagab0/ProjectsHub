import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/info_student.dart';
import 'Student.dart';

class Project {
  String P_title = "";
  String pid = "";
  String P_description = "";
  int? num_members = 1;
  List<dynamic> positions_needed;
  //List<Student>? p_members;
  //List<student_role> member_role = [];
  List<dynamic> member_role = [];
  String P_image = "Default.jpg";
  DateTime created_on;
  String p_owner;

  Project({
    required this.pid,
    required this.P_title,
    required this.P_description,
    required this.positions_needed,
    required this.p_owner,
    required this.member_role,
    required this.created_on,
    required this.P_image,
  });

  // add position to positions list
  void _addposition(String position_name) {
    if (position_name != null) {
      this.positions_needed.add(position_name);
      //print('positions list ${positions_needed}');
    }
  }

  // add student to project
  void addStudent(Map sr) {
    member_role.add(sr);
    //print('type is :${member_role[0]}');
  }

  // remove student to project

  // Store project in firestore
  Map saveProjectDb(Project p) {
    final save_out = {
      'pid': p.pid,
      'name': p.P_title,
      'description': p.P_description,
      'positions_needed': p.positions_needed,
      'Project Owner': p.p_owner,
      'created on': p.created_on,
      'member-role': p.member_role,
      'P_image': p.P_image
    };
    //print('final save : ${save_out['member-role']}');
    return save_out;
  }
}
