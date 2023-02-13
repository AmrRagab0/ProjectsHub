import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projectshub1/Classes/request.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:provider/provider.dart';
import '../../Classes/Student.dart';
import './components.dart';

class NotifItem extends StatefulWidget {
  request Req;
  NotifItem(this.Req);

  @override
  State<NotifItem> createState() => _NotifItemState();
}

class _NotifItemState extends State<NotifItem> {
  final img_path = 'assets/images/profiles/MH.jpg';
  String message = "couldn't find notification";
  String formulate_notif(request req, String uid) {
    if (req.req_status.toString() == 'status.wait_to_join' &&
        req.Stuid != uid) {
      message =
          '${req.stu_name} wants to join your project ${req.proj_name} as ${req.position_name}';
    } else if (req.req_status.toString() == 'status.wait_to_join' &&
        req.Stuid == uid) {
      message =
          'You applied to ${req.proj_name} as ${req.position_name}. The Project owner will recieve your request.';
    } else {
      if (req.req_status == 'status:Accepted') {
        message =
            'Congrats, you have been accepted to join ${req.proj_name} as ${req.position_name}';
      }
    }

    return message;
  }

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student?>(context);

    final message = formulate_notif(widget.Req, user!.uid);
    if (widget.Req.req_status.toString() == 'status.wait_to_join' &&
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
        child: AcceptCancelWidget(
          img_path: img_path,
          message: message,
          req: widget.Req,
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
      required this.req})
      : super(key: key);

  final String img_path;
  final String message;
  final request req;

  @override
  State<AcceptCancelWidget> createState() => _AcceptCancelWidgetState();
}

class _AcceptCancelWidgetState extends State<AcceptCancelWidget> {
  bool show_buttons = true;
  bool accepted = true;
  @override
  Widget build(BuildContext context) {
    return show_buttons ? button_widget() : Buttonless_widget(accepted);
  }

  Widget button_widget() {
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
                    onPressed: () {
                      DatabseService().addStudentToProject_db(widget.req.Stuid,
                          widget.req.position_name, widget.req.proj_id);
                      setState(() {
                        show_buttons = false;
                        widget.req.req_status = status.Accepted;
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
                    //DatabseService().deleteRequest(widget.req.rid);
                    setState(() {
                      show_buttons = false;
                      accepted = false;
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

  Widget Buttonless_widget(bool accepted) {
    String message = '';
    if (accepted) {
      message =
          'You ACCEPTED ${widget.req.stu_name} as ${widget.req.position_name} in your Project:${widget.req.proj_name}';
    } else {
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
