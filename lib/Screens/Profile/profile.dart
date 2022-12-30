import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/Student.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:projectshub1/animation/loading.dart';
import 'package:provider/provider.dart';

import 'components.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  //Size screenSize = MediaQuery.of(context).size;
  List<String> skills = ['python', 'c++', 'Java'];
  String email_address = 'MHashem@gmail.com';

  Widget _oneSkill(String skill) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 15,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          skill,
          style: TextStyle(
              fontFamily: 'san fran',
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _skillbuilder(BuildContext context, int skill_index) {
    return _oneSkill(skills[skill_index]);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student?>(context);
    return Scaffold(
      appBar: AppBar(
        title: heading1_text(text: 'Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<Student>(
          stream: DatabseService(St_uid: user!.uid).studentStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Student me = snapshot.data!;
              return Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      /*
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/images/Profile Background.png'),
                        fit: BoxFit.fill),
                  ),
                  */

                      child: Container(
                        height: 5,
                        width: 5,
                        //alignment: Alignment.center,
                        child: CircleAvatar(
                          maxRadius: 15,
                          backgroundImage: NetworkImage(
                            me.Profile_image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: heading1_text(text: 'Contact'),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: heading2_text("Email Address")),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: normal_text(me.Email_address)),
                          //_oneSkill('Python'),
                          //ListView(),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              itemBuilder: _skillbuilder,
                              itemCount: skills.length,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Loading();
            }
          }),
    );
  }

  Widget profileImage(String im_url) {
    return Container();
  }
}
