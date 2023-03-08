import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'components.dart';

import '../../Classes/Student.dart';

class showProfile extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 144;
  final Student st;

  showProfile(this.st);
  //const showProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const blackA = Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SlidingUpPanel(
        minHeight: screenHeight * 0.6,
        maxHeight: screenHeight * 0.8,
        body: buildTop(st, blackA),
        panelBuilder: (controller) => buildHeader(controller, st),
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
    ;
  }

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
