import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:projectshub1/animation/loading.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Menu/Menu.dart';
import '../Profile/ProfileScreen.dart';
import 'components.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String newBio = '';
  String newName = '';
  List<Widget> skillsWidgetList = [];
  List<dynamic> skillsList = [];
  List<String> newSkills = [];
  static const Color dark_black = Color(0xFF000000);
  final formKey = GlobalKey<FormState>();

  Widget addNewSkillButton() {
    return TextButton(
      child: Text("Add Skill",
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
      onPressed: _addNewSkill,
    );
  }

  void _addNewSkill() {
    skillsWidgetList.add(SkillField('new skill'));
    skillsList.add('new skill');
    setState(() {});
  }

  Widget editNamefield(String init_name) {
    return TextFormField(
      initialValue: init_name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'san fran',
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
            fontFamily: 'san fran',
            fontWeight: FontWeight.bold,
            color: Colors.black),
        labelText: 'Your Name',
        fillColor: Colors.black,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (value) {
        if (value!.length < 3) {
          return 'Name is too short';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        if (this.mounted) {
          setState(() {
            newName = value!;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> participated_in = [];
    final user = Provider.of<Student?>(context);

    final hamada = DatabseService(St_uid: user!.uid).studentStream;

    /*
    for (var i = 0; i < skillsList.length; i++) {
      skillsWidgetList.add(
        SkillField(skillsList[i]),
      );
    }
    
    */

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<Student>(
          stream: DatabseService(St_uid: user.uid).studentStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Student me = snapshot.data!;
              skillsList = me.skills;
              for (var i = 0; i < skillsList.length; i++) {
                skillsWidgetList.add(
                  SkillField(skillsList[i]),
                );
              }
              return Container(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              image: DecorationImage(
                                  image: NetworkImage(user.Profile_image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          editNamefield(me.First_name),
                          SizedBox(
                            height: 10,
                          ),
                          //editBio('add your bio here'),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: heading1_text(text: "SKILLS"),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (_, index) => skillsWidgetList[index],
                            itemCount: skillsList.length,
                          ),
                          //addNewSkillButton(),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate() == true) {
                                formKey.currentState!.save();

                                me.skills = newSkills;

                                me.First_name = newName;
                                DatabseService()
                                    .updateProfile(me.uid, newName, newSkills);
                              }
                              //ShowMessage();
                              Navigator.pop(context);
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
                                  'Save Profile',
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
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget editBio(String bio) => TextFormField(
        maxLines: null,
        initialValue: bio,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'san fran',
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'san fran',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          labelText: 'Your bio',
          fillColor: Colors.black,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value!.length < 3) {
            return 'Your bio is too short !';
          } else {
            return '';
          }
        },
        onChanged: (value) {
          setState(() {
            newBio = value;
          });
        },
      );

  Widget SkillField(String skill) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        initialValue: skill,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'san fran',
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'san fran',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          labelText: 'Skill',
          fillColor: Colors.black,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value!.length < 3) {
            return 'Name is too short';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (this.mounted) {
            setState(() {
              newSkills.add(value!);
            });
          }
        },
      ),
    );
  }
}



/*
Widget BigButton() {
  const Color dark_black = Color(0xFF000000);
  return GestureDetector(
      onTap: () {
        print('validation : ${formKey.currentState!.validate()}');
        if (formKey.currentState!.validate() == true) {
          DatabseService(St_uid: user.uid).updateStudentData(
              user.uid,
              user.First_name,
              "",
              user.Email_address,
              user.Profile_image,
              user.current_projects);

          Navigator.pop(context);
        }
      },
      child: SizedBox(
          height: 50,
          width: 10,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(dark_black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: dark_black)))),
            child: Text(
              'Create Project',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'san fran',
                  fontWeight: FontWeight.normal),
            ),
          )));
}
*/
