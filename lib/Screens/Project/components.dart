import 'package:flutter/material.dart';
import 'package:projectshub1/Services/database.dart';
import '../../Classes/request.dart';
import '../../Classes/Student.dart';

Widget heading2_text(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'san fran',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget normal_text(String text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: 'san fran',
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black),
  );
}

Widget editableText(bool edit, TextEditingController textEditor) {
  if (edit) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(child: heading1_text('Edit Description')),
            IconButton(
              onPressed: () {
                setState() {
                  edit = false;
                }
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        TextField(
          controller: textEditor,
          onChanged: ((value) {
            setState() {
              textEditor.text = value;
            }
          }),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        Row(
          children: [
            heading1_text('Description'),
            IconButton(
              onPressed: () {
                setState() {
                  edit = false;
                  print('a');
                }
              },
              icon: Icon(Icons.edit_note),
            )
          ],
        ),
        Text(
          textEditor.text,
          style: TextStyle(fontFamily: 'san fran', fontSize: 18),
        ),
      ],
    );
  }
}

Widget heading1_text(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'san fran',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

Widget profilePicture(imagePath) {
  return CircleAvatar(
    radius: 20,
    child: ClipOval(
      child: Image.asset(imagePath),
    ),
  );
}

Widget PositionNeeded(String positionName, String text, Student st,
    String proj_id, String proj_name) {
  return Padding(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          positionName,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: SizedBox(),
        ),
        roundedButton(text, positionName, st, proj_id, proj_name),
      ],
    ),
  );
}

Widget roundedButton(String text, String positionName, Student st,
    String proj_id, String proj_name) {
  return SizedBox(
    height: 35,
    width: 80,
    child: ElevatedButton(
      onPressed: () async {
        final request r = request(
            Stuid: st.uid,
            stu_name: st.First_name,
            proj_id: proj_id,
            proj_name: proj_name,
            position_name: positionName);
        final result = DatabseService(St_uid: st.uid).storeNewRequest(r);

        // notify the owner of the project
        final res = DatabseService(St_uid: st.uid).Notify_proj_owner(r);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 10, 51, 121)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromARGB(255, 10, 51, 121))))),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'san fran',
              fontWeight: FontWeight.normal),
        ),
      ),
    ),
  );
}

Widget adminPositionsNeeded(String positionName, String text) {
  return Padding(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          fit: FlexFit.tight, // FUCK, IT FINALLY WORKS
          child: Text(
            positionName,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        flexRoundButton(text),
      ],
    ),
  );
}

Widget flexRoundButton(String text) {
  return ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 10, 51, 121)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Color.fromARGB(255, 10, 51, 121))))),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'san fran',
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget ProjectMember(String name, String img_url, String PositionName) {
  return Padding(
    padding: const EdgeInsets.only(left: 1.0, top: 5, bottom: 5, right: 5),
    child: Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(img_url),
        ),
        SizedBox(
          width: 9,
        ),
        MemberText(name),
        Expanded(child: SizedBox()),
        MemberPosition(PositionName),
      ],
    ),
  );
}

Widget MemberText(String text) {
  return Text(text,
      style: TextStyle(
        fontFamily: 'san fran',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ));
}

Widget MemberPosition(String text) {
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15)),
    //color: Colors.black,
    child: MemberText(text),
  );
}

Widget editBlock(String text) {
  return Column(
    children: [
      Row(
        children: [
          Align(
            child: heading1_text('Description'),
            alignment: Alignment.centerLeft,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
        ],
      ),
      Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'san fran',
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  );
}
