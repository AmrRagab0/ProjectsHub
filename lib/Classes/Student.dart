import 'Project.dart';

class Student {
  final String uid;
  late String First_name = '';
  late String Last_name = '';
  late String Email_address = '';
  String Profile_image = '';
  List<String> skills = [
    'Python Developer',
    'App Developer',
    'Designer',
    '5-year slave'
  ];
  List<String> participated_in = [];
  int phone_num = 010;
  List<dynamic> current_projects; // should contain the ids of projects

  Student({
    required this.uid,
    required this.First_name,
    required this.Last_name,
    required this.Email_address,
    required this.Profile_image,
    required this.current_projects,
  });
  //required this.current_projects});

  Map addProjectToUser(List newCurrentProjects) {
    return {'current projects': newCurrentProjects};
  }

  // save user data
  Map saveUserDb(Student s) {
    final save_out = {
      'uid': s.uid,
      'name': s.First_name.replaceAll(RegExp('[^A-Za-z ]'), ''),
      'email': s.Email_address,
      'image url': s.Profile_image,
      'skills': s.skills,
      'phone number': s.phone_num,
      'participated in': s.participated_in,
      'current projects': s.current_projects,
    };
    return save_out;
  }
}
