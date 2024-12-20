import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_svg/parser.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:projectshub1/Classes/Project.dart';
import 'package:projectshub1/Classes/info_student.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:provider/provider.dart';

import '../../Classes/Student.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({Key? key}) : super(key: key);

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  @override
  String Project_name = '';
  String Project_description = '';
  List<String> positions_needed = [];
  String can_edit = '';
  List<Widget> positions_widgets = [];
  final formKey = GlobalKey<FormState>();

  List<String> all_images = [
    'assets/images/Backgrounds/blue.jpg',
    "assets/images/Backgrounds/darkblue.jpg",
    "assets/images/Backgrounds/Default.jpg",
    "assets/images/Backgrounds/lamb.jpg",
    "assets/images/Backgrounds/purple.jpg",
    "assets/images/Backgrounds/tree.jpg",
    "assets/images/Backgrounds/wood.jpg"
  ];

  static const Color dark_black = Color(0xFF000000);

  void ShowMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Nice !',
          message: 'Your Project has been created!',
          contentType: ContentType.success,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget buildProjectName() => TextFormField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'san fran',
        ),
        decoration: InputDecoration(
          labelStyle:
              TextStyle(fontFamily: 'san fran', fontWeight: FontWeight.bold),
          labelText: 'Project Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 3) {
            return 'Project name is too short';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            Project_name = value;
          });
        },
      );

  Widget buildProjectDescription() => TextFormField(
        minLines: 3,
        style: TextStyle(fontFamily: 'san fran', fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          labelText: 'Project Description',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            Project_description = value;
          });
        },
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Please add a description !';
          } else {
            return null;
          }
        },
        maxLines: null,
      );

  Widget buildPosition() {
    return SizedBox(
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        style: TextStyle(fontFamily: 'san fran'),
        decoration: const InputDecoration(
          hintText: 'Position',
          //contentPadding: ,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: dark_black)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: dark_black)),
          icon: Icon(
            Icons.person_add_outlined,
            color: dark_black,
          ),
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'You have an empy position !';
          }
          positions_needed.add(value!);
          print("added : ${value}");

          return null;
        },
      ),
    );
  }

  Widget addNewPositionButton() {
    return TextButton(
      child: Text("Add position",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'san fran',
              fontWeight: FontWeight.bold)),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
      onPressed: _addNewPosition,
    );
  }

  void _addNewPosition() {
    positions_widgets.add(buildPosition());
    setState(() {});
  }

  Widget removePositionButton() {
    return TextButton(
      child: Text("remove position",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'san fran',
              fontWeight: FontWeight.normal)),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
      onPressed: _removePosition,
    );
  }

  void _removePosition() {
    positions_widgets.removeLast();
    positions_needed.removeLast();
    setState(() {});
  }

  Widget build(BuildContext context) {
    final user = Provider.of<Student?>(context);
    Random random = new Random();
    int randomNumber = random.nextInt(6);

    return StreamBuilder<Student>(
      stream: DatabseService(St_uid: user!.uid).studentStream,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          Student me = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Create New Project',
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontFamily: 'san fran'),
              ),
            ),
            body: Form(
              key: formKey,
              child: ListView(padding: EdgeInsets.all(10), children: [
                SizedBox(
                  height: 20,
                ),
                buildProjectName(),
                SizedBox(height: 10),
                buildProjectDescription(),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Looking for',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'san fran',
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildPosition(),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => positions_widgets[index],
                  itemCount: positions_widgets.length,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    addNewPositionButton(),
                    SizedBox(
                      width: 20,
                    ),
                    //removePositionButton(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    print('validation : ${formKey.currentState!.validate()}');
                    if (formKey.currentState!.validate() == true) {
                      positions_needed = positions_needed.toSet().toList();
                      Project p = Project(
                          pid: '',
                          P_title: Project_name,
                          P_description: Project_description,
                          positions_needed: positions_needed,
                          p_owner: me.uid,
                          created_on: DateTime.now(),
                          member_role: [],
                          P_image: all_images[randomNumber]);

                      Map sr = {
                        "uid": me.uid,
                        "First_name": me.First_name,
                        "Profile_image": me.Profile_image,
                        'Role': "Project Owner"
                      };
                      final result = DatabseService().storeNewProject(p, sr);

                      user.current_projects.add(await result);

                      DatabseService(St_uid: user.uid).updateStudentData(
                          user.uid,
                          user.First_name,
                          "",
                          user.Email_address,
                          user.Profile_image,
                          user.current_projects);

                      ShowMessage();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: dark_black,
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(color: dark_black),
                    ),
                    child: Center(
                      child: Text(
                        'Create Project',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'san fran',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
