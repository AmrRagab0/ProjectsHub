import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Classes/info_student.dart';
import 'package:projectshub1/Services/auth.dart';
import '../Classes/Project.dart';
import '../Classes/request.dart';

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

  final CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('Requests');

  /*
  Future updateUserData(
      String first_name, String last_name, String Email) async {
    return await rootCollection.doc(uid).set(
        {'first_name': first_name, 'last_name': last_name, 'Email': Email});
  }
  */
  Future updateStudentData(String S_uid, String first_name, String last_name,
      String email, String image_url, List<dynamic> Current_Projects) async {
    Student s = Student(
      uid: S_uid,
      First_name: first_name,
      Last_name: last_name,
      Email_address: email,
      Profile_image: image_url,
      current_projects: Current_Projects,
    );
    print('should creeate notification page');
    await requestsCollection.doc(S_uid).set({
      'notifications': [{}]
    });
    //print('this is id:${s.uid}');
    //print(s.saveUserDb(s));

    return await studentsCollection.doc(S_uid).set(s.saveUserDb(s));
  }

  Future<String> storeNewProject(Project P, Map sr) async {
    //print('saved: ${P.saveProjectDb(P)}');
    P.addStudent(sr);
    //print("mem is : ${P.member_role[0]}");
    final String result = await projectsCollection
        .add(P.saveProjectDb(P))
        .then((DocumentSnapshot) {
      return DocumentSnapshot.id.toString();
    });
    await projectsCollection.doc(result).update({'pid': result});
    print('Result ${result}');
    return result;
  }

  Future<String> storeNewRequest(request r) async {
    var snapshot = await requestsCollection.doc(r.Stuid).get();
    if (snapshot.exists) {
      print('snap shot: ${snapshot.get('notifications')}');
      List<dynamic> all_notifications = snapshot.get('notifications');

      all_notifications.add(r.SaveReqDB(r));
      await requestsCollection
          .doc(r.Stuid)
          .set({'notifications': all_notifications});
    } else {
      List<dynamic> all = [];
      all.add(r.SaveReqDB(r));
      print('all ya hamada:${r.SaveReqDB(r).runtimeType}');

      await requestsCollection.doc(r.Stuid).set({'notifications': all});
    }
    //await requestsCollection.doc(r.Stuid).update();

    return 'done';
  }

  Future<String> Notify_proj_owner(request r) async {
    var snapshot = await projectsCollection.doc(r.proj_id).get();
    String P_owner = snapshot.get('Project Owner');
    var owner_notif = await requestsCollection.doc(P_owner).get();
    List<dynamic> all_notifications = owner_notif.get('notifications');

    all_notifications.add(r.SaveReqDB(r));
    print('all${all_notifications}');
    await requestsCollection
        .doc(P_owner)
        .set({'notifications': all_notifications});

    return 's';
  }

  Student _getStudentFromDB(DocumentSnapshot snapshot) {
    return Student(
      uid: St_uid!,
      First_name: snapshot.get('name'),
      Email_address: snapshot.get('email'),
      Last_name: '',
      Profile_image: snapshot.get('image url'),
      current_projects: snapshot.get('current projects'),
    );
    //current_projects: snapshot.get('current projects'));
  }

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
        pid: doc.get('pid'),
        P_title: doc.get('name') ?? '',
        P_description: doc.get('description') ?? '',
        positions_needed: doc.get('positions_needed') ?? '',
        p_owner: doc.get('Project Owner') ?? '',
        member_role: doc.get('member-role') ?? {},
        P_image: doc.get('P_image') ?? '',
      );
    }).toList();
  }

  void deleteProject(id) {
    projectsCollection.doc(id).delete();
  }
}
