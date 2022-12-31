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
  String newName = '';

  @override
  Widget build(BuildContext context) {
    List<String> skillsList = [];
    List<Widget> skillsWidgetList = [];
    List<String> participated_in = [];
    final user = Provider.of<Student?>(context);
    skillsList = user!.skills;
    print('skills list: ${skillsList}');
    for (var i = 0; i < skillsList.length; i++) {
      skillsWidgetList.add(
        SkillField(skillsList[i]),
      );
    }
    print(skillsWidgetList);
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                    child: Column(
                      children: [
                        editNamefield(user.First_name),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: heading1_text(text: "SKILLS"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, index) => skillsWidgetList[index],
                          itemCount: skillsWidgetList.length,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget editNamefield(String init_name) => TextFormField(
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
        onChanged: (value) {
          setState(() {
            newName = value;
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
        onChanged: (value) {
          setState(() {
            newName = value;
          });
        },
      ),
    );
  }
}
