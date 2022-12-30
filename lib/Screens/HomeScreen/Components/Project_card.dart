import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projectshub1/Classes/Project.dart';

class Project_card extends StatelessWidget {
  late Project theProject;

  Project_card({required this.theProject});
  /*
  final String P_title;
  final String position1;
  final String position2;
  final String position3;
  final String position4;
  final String ImageName;
  
  Project_card(
      {required this.P_title,
      required this.position1,
      this.position2 = '',
      this.position3 = '',
      this.position4 = '',
      this.ImageName = 'Default.jpg'})
      : assert(P_title != null),
        assert(position1 != null);
  */
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 7,
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/${theProject.imageName}',
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
            width: 357,
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
                  child: Row(children: [
                    PositionNeeded(theProject.positions_needed[0]),
                    //PositionNeeded(theProject.positions_needed[]),
                  ]),
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
                              CircleAvatar(
                                radius: 12,
                                backgroundImage:
                                    AssetImage('assets/images/profiles/AG.jpg'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(
                                    'assets/images/profiles/Hashem.jpg'),
                              ),
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
    );
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
              Icons.panorama_fish_eye,
              size: 15,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
