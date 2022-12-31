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
import 'package:flutter/rendering.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double coverHeight = 200;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final user = Provider.of<Student?>(context);
    const blackA = Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<Student>(
        stream: DatabseService(St_uid: user!.uid).studentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Student me = snapshot.data!;

            return SlidingUpPanel(
              minHeight: screenHeight * 0.6,
              maxHeight: screenHeight * 0.8,
              body: buildTop(me, blackA),
              panelBuilder: (controller) => buildHeader(controller, me),
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  /*
  Expanded(flex: 3, child: buildTop(me, blackA)),
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
                      child: buildHeader(me),
                    ),
                  ),

  */
  Widget buildTop(Student u, Color b) {
    final top = coverHeight / 3;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: coverPlain(b),
          //margin: EdgeInsets.only(bottom: profileHeight / 4),
        ),
        Positioned(
          top: top - 50,
          child: profileImage(u.Profile_image),
        ),
      ],
    );
  }

  Widget buildHeader(ScrollController cont, Student u) {
    return ListView(
      controller: cont,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                u.First_name,
                style: TextStyle(
                  fontFamily: 'san fran',
                  fontWeight: FontWeight.bold,
                  fontSize: 29,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Block('Contact', [u.Email_address]),
              Block('Skills', u.skills),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContent(Student m) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          contentBlock(stu: m, head1: 'Content'),
        ],
      ),
    );
  }

  Widget contentBlock({required Student stu, required String head1}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: heading1_text(text: head1, c: Colors.black),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: heading2_text(stu.Email_address),
        ),
      ],
    );
  }

  Widget profileImage(String im_url) {
    return CircleAvatar(
      radius: profileHeight / 1.7,
      child: ClipOval(
        child: Image.network(
          im_url.substring(0, im_url.length - 6),
          height: (profileHeight / 1.7) * 2,
          width: (profileHeight / 1.7) * 2,
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }

  Widget coverImage() {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        'assets/images/landscape.jpeg',
        height: coverHeight,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget coverPlain(Color a) {
    return Container(
      color: a,
    );
  }
}
