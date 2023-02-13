import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projectshub1/Classes/Project.dart';
import 'package:projectshub1/Screens/Profile/ProfileScreen.dart';
import 'package:projectshub1/Screens/Project/ProjectScreen.dart';
import 'package:projectshub1/Screens/Project/AdminProjectScreen.dart';
import 'package:projectshub1/Services/database.dart';
import '../../../Classes/Student.dart';

class Project_card extends StatelessWidget {
  late Project theProject;

  Project_card({required this.theProject});

  Widget membersImages(Project p) {
    return Row(
      children: [
        for (var i in p.member_role)
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(i['Profile_image']),
          ),
      ],
    );
  }

  Widget lookingFor_list(List l) {
    return Row(
      children: [
        for (var i in l.take(3)) Flexible(child: PositionNeeded(i)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Student>(
        stream: DatabseService().studentStream,
        builder: (context, snapshot) {
          Student? S = snapshot.data;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext Context) =>
                      ProjectScreen(this.theProject),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 7,
              margin: EdgeInsets.all(7),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "${theProject.P_image}",
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(0.8)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 1])),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: CardText(theProject.P_title),
                    height: 70,
                    alignment: Alignment.bottomLeft,
                  ),
                  Positioned(
                    top: 65,
                    height: 109,
                    width: 383,
                    //width: MediaQuery.of(context).size.width * 0.8,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Looking for",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'san fran',
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          height: 25,
                          padding: EdgeInsets.only(left: 3),
                          child: lookingFor_list(theProject.positions_needed),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(bottom: 7),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                    left: 9,
                                    top: 8,
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    'Members',
                                    style: TextStyle(
                                      fontFamily: 'san fran',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 7),
                                  child: Row(
                                    children: [
                                      membersImages(theProject),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CardText extends StatelessWidget {
  //const CardText({Key? key}) : super(key: key);
  final String Title;
  CardText(this.Title);
  @override
  Widget build(BuildContext context) {
    return Text(
      Title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}

class PositionNeeded extends StatelessWidget {
  final String title;
  PositionNeeded(this.title);

  @override
  Widget build(BuildContext context) {
    if (!title.isEmpty) {
      return Container(
        height: 30,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              Icons.circle_outlined,
              size: 13,
            ),
            SizedBox(
              width: 4,
            ),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
