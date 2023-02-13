import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/request.dart';
import 'package:projectshub1/Screens/Notifications/NotificationItem.dart';
import 'package:projectshub1/Screens/Project/components.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:provider/provider.dart';
import '../../Classes/Student.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student?>(context);

    List updated_notifs = [];

    return StreamBuilder<List<dynamic>>(
        stream: DatabseService(St_uid: user!.uid).getData(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List all_notifs = snapshot.data ?? [];

            //all_notifs.sort((a, b) => a.created_on.compareTo(b.created_on));
            all_notifs.toSet();
            all_notifs.toList();
            return Scaffold(
              appBar: AppBar(
                title: Text('Notifications'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: SingleChildScrollView(
                /*
                
                */
                child: Container(
                  child: SafeArea(
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        for (var i in all_notifs.sublist(1)) NotifItem(i)
                      ]),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Text("Error fetching notifications"),
            );
          } else {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
