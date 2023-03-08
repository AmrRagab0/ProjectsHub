import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:projectshub1/Screens/Profile/ProfileScreen.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projectshub1/Classes/request.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:projectshub1/variables.dart';
import 'package:provider/provider.dart';
import '../../Classes/Student.dart';
import '../Profile/showProfile.dart';
import './components.dart';

//enum status { Accepted, Rejected, wait_to_join }
class NotifItem extends StatefulWidget {
  request Req;

  NotifItem(this.Req);

  @override
  State<NotifItem> createState() => _NotifItemState();
}

class _NotifItemState extends State<NotifItem> {
  final img_path = 'assets/icons/notification.jpg';
  String message = "couldn't find notification";

  void updateStatus(status newstatus) {
    setState(() {
      widget.Req.req_status = newstatus;
    });
  }

  String formulate_notif(request req, String uid) {
    //print(
    //  '${req.position_name} have stuid:${req.Stuid}  and owner:${req.proj_owner_id}');
    if (req.req_status.toString() == 'status.wait_to_join' &&
        req.Stuid != uid) {
      message =
          '${req.stu_name} wants to join your project ${req.proj_name} as ${req.position_name}';
    } else if (req.req_status.toString() == 'status.wait_to_join' &&
        req.Stuid == uid) {
      message =
          'You applied to ${req.proj_name} as ${req.position_name}. The Project owner will recieve your request.';
    } else {
      if (req.req_status.toString() == 'status.Accepted') {
        message =
            'Congrats, you have been accepted to join ${req.proj_name} as ${req.position_name}';
      } else if (req.req_status.toString() == 'status.Rejected' &&
          req.Stuid == uid) {
        message =
            "We are sorry, Project : ${req.proj_name} is not suitable for you";
      } else {
        //print('wtf');
        message =
            'You REJECTED ${req.stu_name} as ${req.position_name} in your Project:${req.proj_name}';
      }
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    //print(
    //  'status for ${widget.Req.position_name} is ${widget.Req.req_status.toString()}');
    final user = Provider.of<Student?>(context);

    final message = formulate_notif(widget.Req, user!.uid);
    //print('message :${message}');
    if ((widget.Req.req_status.toString() == 'status.wait_to_join' ||
            widget.Req.req_status.toString() == 'status.Accepted') &&
        widget.Req.Stuid == user.uid) {
      return ListTile(
        onTap: () {},
        enabled: true,
        leading: Container(
          padding: EdgeInsets.all(5),
          height: 80,
          child: profilePicture(img_path),
        ),
        title: Column(
          children: <Widget>[
            Text(
              message,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.3,
                  fontFamily: 'san fran',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Container(
        //height: 80,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: AcceptCancelWidget(
            img_path: img_path,
            message: message,
            req: widget.Req,
            onbuttonpressed: updateStatus,
            UserId: user.uid,
            newSt: widget.Req.req_status,
          ),
        ),
      );
    }
  }
}

class AcceptCancelWidget extends StatefulWidget {
  const AcceptCancelWidget(
      {Key? key,
      required this.img_path,
      required this.message,
      required this.UserId,
      required this.newSt,
      required this.onbuttonpressed,
      required this.req})
      : super(key: key);

  final String img_path;
  final String message;
  final request req;
  final String UserId;
  final status newSt;
  final ValueChanged<status> onbuttonpressed;

  @override
  State<AcceptCancelWidget> createState() => _AcceptCancelWidgetState();
}

class _AcceptCancelWidgetState extends State<AcceptCancelWidget> {
  String elmessage = '';

  late bool show_buttons;
  late bool accepted;
  bool showWidget = true;
  void initState() {
    super.initState();
    accepted = widget.req.req_status == status.Accepted;
    elmessage = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.req.req_status.toString() == 'status.wait_to_join') {
      show_buttons = true;
    } else {
      show_buttons = false;
    }

    if (show_buttons) {
      return button_widget(widget.req.Stuid);
    } else {
      return Buttonless_widget(
          accepted, widget.req.Stuid, widget.req.proj_owner_id, elmessage);
    }
  }

  Widget button_widget(String id) {
    return ListTile(
      onTap: () async {
        Student st = await DatabseService().getStudentbyId(id);
        print('student is : ${st}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext Context) => showProfile(st),
          ),
        );
      },
      enabled: true,
      leading: Container(
        padding: EdgeInsets.all(5),
        height: 80,
        child: profilePicture(widget.img_path),
      ),
      title: Column(
        children: <Widget>[
          Text(
            widget.message,
            style: TextStyle(
                color: Colors.black,
                height: 1.3,
                fontFamily: 'san fran',
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                    //color: Colors.blue[700],
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      "Accept",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'san fran',
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () async {
                      widget.req.req_status = status.Accepted;
                      //DatabseService().addStudentToProject_db(widget.req.Stuid,
                      //  widget.req.position_name, widget.req.proj_id);
                      try {
                        await DatabseService().addStudentToProject_db(
                            widget.req.Stuid,
                            widget.req.position_name,
                            widget.req.proj_id);
                        widget.req.req_status = status.Accepted;
                      } catch (e) {
                        widget.req.req_status = status.Rejected;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      DatabseService()
                          .addOrUpdateReq(widget.req.Stuid, widget.req);
                      DatabseService()
                          .addOrUpdateReq(widget.req.proj_owner_id, widget.req);

                      showWidget = false;

                      setState(() {
                        show_buttons = false;
                        accepted = true;
                        //widget.req.req_status = status.Accepted;
                        widget.onbuttonpressed(widget.req.req_status);
                      });
                    }),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  //borderSide: BorderSide(color: Colors.grey[500]),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'san fran',
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    // Add your cancel button action here
                    widget.req.req_status = status.Rejected;
                    DatabseService()
                        .addOrUpdateReq(widget.req.Stuid, widget.req);
                    DatabseService()
                        .addOrUpdateReq(widget.req.proj_owner_id, widget.req);

                    setState(() {
                      show_buttons = false;
                      accepted = false;
                      widget.req.req_status = status.Rejected;
                      widget.onbuttonpressed(status.Rejected);
                      showWidget = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Buttonless_widget(
      bool accepted, String userid, String ownerId, String message) {
    ;
    if (accepted) {
      message =
          'You ACCEPTED ${widget.req.stu_name} as ${widget.req.position_name} in your Project:${widget.req.proj_name}';
    } else if (accepted == false && userid == ownerId) {
      message =
          'You REJECTED ${widget.req.stu_name} as ${widget.req.position_name} in your Project:${widget.req.proj_name}';
    }
    return ListTile(
      onTap: () {},
      enabled: true,
      leading: Container(
        padding: EdgeInsets.all(5),
        height: 80,
        child: profilePicture(widget.img_path),
      ),
      title: Column(
        children: <Widget>[
          Text(
            message,
            style: TextStyle(
                color: Colors.black,
                height: 1.3,
                fontFamily: 'san fran',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    ;
  }
}





/*
Row(
      children: [
        profilePicture(img_path),
        Flexible(
          child: normal_text(message),
        ),
      ],
    )
RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "This is  bold text. ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "This is some italic text. ",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: "This is some red text. ",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          )




    */ 
