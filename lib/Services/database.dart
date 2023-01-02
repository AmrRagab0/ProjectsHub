import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Classes/info_student.dart';
import 'package:projectshub1/Services/auth.dart';
import '../Classes/Project.dart';

class DatabseService {
  String? P_uid;
  String? St_uid;
  DatabseService({this.St_uid, this.P_uid});

  //creates a root collection that will contain all sub collections
  // checks if it's already created
  final CollectionReference rootCollection =
      FirebaseFirestore.instance.collection('root');

  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('Students');

  final CollectionReference projectsCollection =
      FirebaseFirestore.instance.collection('Projects');

  /*
  Future updateUserData(
      String first_name, String last_name, String Email) async {
    return await rootCollection.doc(uid).set(
        {'first_name': first_name, 'last_name': last_name, 'Email': Email});
  }
  */
  Future updateStudentData(String S_uid, String first_name, String last_name,
      String email, String image_url) async {
    Student s = Student(
        uid: S_uid,
        First_name: first_name,
        Last_name: last_name,
        Email_address: email,
        Profile_image: image_url);

    //print('this is id:${s.uid}');
    //print(s.saveUserDb(s));
    return await studentsCollection.doc(S_uid).set(s.saveUserDb(s));
  }

  Future storeNewProject(Project P, Map sr) async {
    //print('saved: ${P.saveProjectDb(P)}');
    P.addStudent(sr);
    print("mem is : ${P.member_role[0]}");
    return await projectsCollection.add(P.saveProjectDb(P));
  }

  Student _getStudentFromDB(DocumentSnapshot snapshot) {
    return Student(
      uid: St_uid!,
      First_name: snapshot.get('name'),
      Email_address: snapshot.get('email'),
      Last_name: '',
      Profile_image: snapshot.get('image url'),
    );
  }

  /*
  // list all availabe projects to use for the home screen
  List<Project> allProjects_from_snapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Project(
          P_title: doc.get('P_title') ?? " ",
          P_description: doc.get('P_description') ?? " ",
          positions_needed: doc.get('positions_needed') ?? " ");
    }).toList();
  }
  
  Stream<List<Student>> get all_students {
    return rootCollection
        .snapshots()
        .map((event) => allProjects_from_snapshot(event));
  }
  */

  // returns the student document from firestore
  Stream<Student> get studentStream {
    return studentsCollection.doc(St_uid).snapshots().map(_getStudentFromDB);
  }

  Stream<List<Project>> get projectStream {
    return projectsCollection.snapshots().map(_projectsListFromSnapshot);
  }

  List<Project> _projectsListFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map((doc) {
      print('member role type is: ${doc.get('member-role').runtimeType}');
      return Project(
        P_title: doc.get('name') ?? '',
        P_description: doc.get('description') ?? '',
        positions_needed: doc.get('positions_needed') ?? '',
        p_owner: doc.get('Project Owner') ?? '',
        member_role: doc.get('member-role') ?? {},
      );
    }).toList();
  }
}


/*
class projectsProvider with ChangeNotifier {
  //late List<Project> _All_Projects;

  //List<Project> get All_Projects => _All_Projects;
}
*/
