import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/Profile/ProfileScreen.dart';
import 'package:projectshub1/Screens/Profile/showProfile.dart';
import 'package:projectshub1/Services/database.dart';
import '../../Classes/request.dart';
import '../../Classes/Student.dart';
import 'package:uuid/uuid.dart';

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

Widget PositionNeeded(
    String positionName,
    String text,
    Student st,
    String proj_id,
    String proj_name,
    String proj_owner_id,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${positionName[0].toUpperCase()}${positionName.substring(1).toLowerCase()}",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: roundedButton(text, positionName, st, proj_id, proj_name,
              proj_owner_id, context),
        ),
      ],
    ),
  );
}

Widget roundedButton(
  String text,
  String positionName,
  Student st,
  String proj_id,
  String proj_name,
  String proj_owner_id,
  BuildContext context,
) {
  var uuid = Uuid();
  return SizedBox(
    height: 35,
    width: 80,
    child: ElevatedButton(
      onPressed: () async {
        final request r = request(
          Stuid: st.uid,
          rid: uuid.v4(),
          stu_name: st.First_name,
          proj_id: proj_id,
          created_on: DateTime.now(),
          proj_owner_id: proj_owner_id,
          proj_name: proj_name,
          req_status: status.wait_to_join,
          position_name: positionName,
        );

        final result = DatabseService(St_uid: st.uid).storeNewRequest(r);

        // notify the owner of the project
        final res = DatabseService(St_uid: st.uid).Notify_proj_owner(r);

        // show pop-up message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: heading2_text('Request sent'),
              content: Text('Your request has been sent successfully.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 10, 51, 121)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Color.fromARGB(255, 10, 51, 121)),
          ),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'san fran',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

Widget adminPositionsNeeded(String positionName, String text) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
      children: [
        Icon(
          Icons.panorama_fish_eye,
          size: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${positionName[0].toUpperCase()}${positionName.substring(1).toLowerCase()}",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: flexRoundButton(text),
        ),
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

Widget ProjectMember(String name, String id, String img_url,
    String PositionName, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      var student = await DatabseService().getStudentbyId(id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext Context) => showProfile(student),
        ),
      );
    },
    child: Padding(
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: MemberText(name),
                ),
                MemberPosition(PositionName),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget MemberText(String text) {
  return Text("${text[0].toUpperCase()}${text.substring(1).toLowerCase()}",
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




/* 
// original create project button
 ElevatedButton(
      onPressed: () async {
        final request r = request(
            Stuid: st.uid,
            rid: uuid.v4(),
            stu_name: st.First_name,
            proj_id: proj_id,
            proj_owner_id: proj_owner_id,
            proj_name: proj_name,
            req_status: status.wait_to_join,
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
    */