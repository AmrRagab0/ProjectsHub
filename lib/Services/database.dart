import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Classes/info_student.dart';
import 'package:projectshub1/Services/auth.dart';
import '../Classes/Project.dart';
import 'package:uuid/uuid.dart';
import '../Classes/request.dart';
import 'package:projectshub1/variables.dart';

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
        current_projects: Current_Projects);

    ///print('should creeate notification page');

    DocumentSnapshot documentSnapshot =
        await requestsCollection.doc(S_uid).get();
    if (documentSnapshot.exists) {
      // do nothing

    } else {
      request r = request(
          Stuid: '',
          stu_name: '',
          proj_id: '',
          proj_owner_id: '',
          rid: '',
          proj_name: '',
          req_status: status.wait_to_join,
          position_name: '');
      List<dynamic> empty = [];
      empty.add(r.SaveReqDB(r));

      await requestsCollection.doc(S_uid).set({'notifications': []});
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
      List<dynamic> all_notifications = snapshot.get('notifications');

      all_notifications.add(r.SaveReqDB(r));
      await requestsCollection
          .doc(r.Stuid)
          .set({'notifications': all_notifications});
    } else {
      List<dynamic> all = [];
      all.add(r.SaveReqDB(r));
      //print('all ya hamada:${r.SaveReqDB(r).runtimeType}');

      await requestsCollection.doc(r.Stuid).set({'notifications': all});
    }
    //await requestsCollection.doc(r.Stuid).update();

    return 'done';
  }

  Future<void> updateRequests(String id, List<dynamic> updatedRequests) async {
    List<Map> updatedReqs = [];
    for (var i in updatedRequests) {
      updatedReqs.add(i.SaveReqDB(i));
    }
    return await requestsCollection
        .doc(id)
        .update({'notifications': updatedReqs});
  }

  Future updateOwnerReqs(String id, request newReq) async {
    List<dynamic> owners_reqs_list = [];
    List<dynamic> owner_reqs =
        await DatabseService().getNotifsById(id).then((value) {
      for (var i in value) {
        owners_reqs_list.add(i);
      }
      return owners_reqs_list;
    });

    int index2 = findRequestIndex(owner_reqs, newReq.rid);
    owner_reqs[index2] = newReq.SaveReqDB(newReq);

    DatabseService().updateRequests(newReq.proj_owner_id, owner_reqs);
    return 'done';
  }

  Future<void> addOrUpdateReq(String id, request newReq) async {
    print('updated is :${newReq.req_status}');
    List owner_reqs = await getNotifsById(id);

    int index = findRequestIndex(owner_reqs, newReq.rid);
    if (index != -1) {
      owner_reqs[index] = newReq;
    } else {
      owner_reqs.add(newReq);
    }
    print("type is :${owner_reqs[1].runtimeType}");
    List updatedReqs = owner_reqs.map((req) => req.SaveReqDB(req)).toList();

    await DatabseService().updateRequests(id, owner_reqs);
  }

  Future<List<dynamic>> getRequestsByUser(String userId) async {
    DocumentSnapshot doc = await requestsCollection.doc(userId).get();
    if (doc.exists) {
      return doc['notifications'];
    } else {
      return [];
    }
  }

  Future getNotifsById(String id) async {
    DocumentSnapshot snap = await requestsCollection.doc(id).get();
    return convertSnapToReqs(snap);
  }

  Stream<List<dynamic>> getData(String uid) {
    return requestsCollection.doc(uid).snapshots().map(convertSnapToReqs);
  }

  List<dynamic> convertSnapToReqs(DocumentSnapshot snapshot) {
    List<dynamic> all_notifications = [];
    if (snapshot.exists) {
      List<dynamic> data_full = snapshot.get('notifications');
      //List<dynamic> data = data_full.skip(1).toList();
      var thedata = data_full.reversed;
      var dd = thedata.map((e) => e as Map<String, dynamic>).toList();
      for (var i in dd) {
        //print("fuck :${all_notifications[i['status']]}");
        all_notifications.add(request(
            Stuid: i['stuid'],
            stu_name: i['stu_name'],
            rid: i['rid'],
            proj_owner_id: i['proj_owner_id'],
            proj_id: i['proj_id'],
            proj_name: i['proj_name'],
            req_status: convStatString(i['status']),
            position_name: i['position_name']));
      }

      return all_notifications;
    } else {
      return [];
    }
  }

  status convStatString(String a) {
    if (a == 'status.Accepted') {
      return status.Accepted;
    } else if (a == "status.wait_to_join") {
      return status.wait_to_join;
    } else {
      return status.Rejected;
    }
  }

  Future<String> Notify_proj_owner(request r) async {
    var snapshot = await projectsCollection.doc(r.proj_id).get();
    String P_owner = snapshot.get('Project Owner');
    var owner_notif = await requestsCollection.doc(P_owner).get();
    List<dynamic> all_notifications = owner_notif.get('notifications');

    all_notifications.add(r.SaveReqDB(r));

    await requestsCollection
        .doc(P_owner)
        .set({'notifications': all_notifications});

    return 's';
  }

  Future getProjectSnap(String proj_id) async {
    return await projectsCollection.doc(proj_id).get();
  }

/*
  Future removePosition(String Proj_id, String position_name) async {
    Project updated = await projectsCollection.doc(Proj_id).get().then((value) {
      return getProjectFromDB(value);
    });
    updated.positions_needed.remove(position_name);
    print('new positions: ${updated.positions_needed}');
    return await projectsCollection
        .doc(Proj_id)
        .update({'positions_needed': updated.positions_needed});
  }
*/
  Student _getStudentFromDB(DocumentSnapshot snapshot) {
    return Student(
      uid: snapshot.get('uid'),
      First_name: snapshot.get('name'),
      Email_address: snapshot.get('email'),
      Last_name: '',
      Profile_image: snapshot.get('image url'),
      current_projects: snapshot.get('current projects'),
    );
    //current_projects: snapshot.get('current projects'));
  }

  Future<Student> getStudentbyId(String St_id) async {
    return await studentsCollection
        .doc(St_id)
        .get()
        .then((value) => _getStudentFromDB(value));
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

  Project getProjectFromDB(DocumentSnapshot snap) {
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

//chatgpt : addStudentToProject
  Future<void> addStudentToProject_db(
      String stuid, String position, String proj_id) async {
    // get student full data
    DocumentSnapshot st_snap = await studentsCollection.doc(stuid).get();
    Student st = _getStudentFromDB(st_snap);

    // get project data
    var proj_snap = await projectsCollection.doc(proj_id).get();
    Project pr = getProjectFromDB(proj_snap);

    // check if the position is available
    if (!pr.positions_needed.contains(position)) {
      throw 'Position $position is not available in this project';
    }

    Map sr = {
      "First_name": st.First_name,
      "Profile_image": st.Profile_image,
      "Role": position,
      "uid": st.uid
    };

    // add student to project
    pr.addStudent(sr);

    // remove position
    pr.positions_needed.remove(position);

    // update project doc in the database
    await projectsCollection
        .doc(proj_id)
        .update(pr.saveProjectDb(pr) as Map<String, dynamic>);
  }
}




/*
  Future<void> addStudentToProject_db(
      String stuid, String position, String proj_id) async {
    // get student full data
    DocumentSnapshot st_snap = await studentsCollection.doc(stuid).get();

    Student st = _getStudentFromDB(st_snap);
    // get project data
    var proj_snap = await projectsCollection.doc(proj_id).get();
    Project pr = getProjectFromDB(proj_snap);

    Map sr = {
      "First_name": st.First_name,
      "Profile_image": st.Profile_image,
      "Role": position,
      "uid": st.uid
    };
    // add student to project
    pr.addStudent(sr);

    // remove position
    pr.positions_needed.remove(position);
    // update project doc in the database
    await projectsCollection
        .doc(proj_id)
        .update(pr.saveProjectDb(pr) as Map<String, dynamic>);
  }

*/