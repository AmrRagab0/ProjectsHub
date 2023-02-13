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

    ///print('should creeate notification page');

    DocumentSnapshot documentSnapshot =
        await requestsCollection.doc(S_uid).get();
    if (documentSnapshot.exists) {
      // do nothing

    } else {
      await requestsCollection.doc(S_uid).set({
        'notifications': [{}]
      });
    }

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
    //print('Result ${result}');
    return result;
  }

  Future<String> storeNewRequest(request r) async {
    var snapshot = await requestsCollection.doc(r.Stuid).get();
    if (snapshot.exists) {
      print('snap shot: ${snapshot.get('notifications')}');
      List<dynamic> all_notifications = snapshot.get('notifications');
      print('found requests');
      all_notifications.add(r.SaveReqDB(r));
      await requestsCollection
          .doc(r.Stuid)
          .set({'notifications': all_notifications});
    } else {
      print('didnt find requests');
      List<dynamic> all = [];
      all.add(r.SaveReqDB(r));
      //print('all ya hamada:${r.SaveReqDB(r).runtimeType}');

      await requestsCollection.doc(r.Stuid).set({'notifications': all});
    }
    //await requestsCollection.doc(r.Stuid).update();

    return 'done';
  }

  Stream<List<dynamic>> getData(String uid) {
    return requestsCollection.doc(uid).snapshots().map(convertSnapToReqs);
  }

  List<dynamic> convertSnapToReqs(DocumentSnapshot snapshot) {
    List<dynamic> all_notifications = [];
    if (snapshot.exists) {
      print('found it');
      List<dynamic> data_full = snapshot.get('notifications');
      List<dynamic> data = data_full.skip(1).toList();
      var thedata = data.reversed;
      var dd = thedata.map((e) => e as Map<String, dynamic>).toList();
      for (var i in dd) {
        all_notifications.add(request(
            Stuid: i['stuid'],
            stu_name: i['stu_name'],
            proj_id: i['proj_id'],
            proj_name: i['proj_name'],
            position_name: i['position_name']));
      }
      print('el list:${all_notifications}');
      return all_notifications;
    } else {
      return [];
    }
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
      uid: 'j',
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
      //print('member role type is: ${doc.get('member-role').runtimeType}');
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

  Project _getProjectFromDB(DocumentSnapshot snap) {
    //print('member role type is: ${doc.get('member-role').runtimeType}');
    return Project(
      pid: snap.get('pid'),
      P_title: snap.get('name') ?? '',
      P_description: snap.get('description') ?? '',
      positions_needed: snap.get('positions_needed') ?? '',
      p_owner: snap.get('Project Owner') ?? '',
      member_role: snap.get('member-role') ?? {},
      P_image: snap.get('P_image') ?? '',
    );
  }

  void deleteProject(id) {
    projectsCollection.doc(id).delete();
  }

  void deleteRequest(id) {
    requestsCollection.doc(id).delete();
  }

  Future<void> addStudentToProject_db(
      String stuid, String position, String proj_id) async {
    // get student full data
    DocumentSnapshot st_snap = await studentsCollection.doc(stuid).get();

    Student st = _getStudentFromDB(st_snap);
    // get project data
    var proj_snap = await projectsCollection.doc(proj_id).get();
    Project pr = _getProjectFromDB(proj_snap);

    Map sr = {
      "First_name": st.First_name,
      "Profile_image": st.Profile_image,
      "Role": position,
      "uid": st.uid
    };
    // add student to project
    pr.addStudent(sr);
    // update project doc in the database
    await projectsCollection
        .doc(proj_id)
        .update(pr.saveProjectDb(pr) as Map<String, dynamic>);
  }
}
