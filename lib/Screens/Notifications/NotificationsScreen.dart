import 'package:flutter/material.dart';
import 'package:projectshub1/Classes/request.dart';
import 'package:projectshub1/Screens/Notifications/NotificationItem.dart';
import 'package:projectshub1/Screens/Project/components.dart';
import 'package:projectshub1/Services/database.dart';
import 'package:provider/provider.dart';
import '../../Classes/Student.dart';
import '../../variables.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student?>(context);

    return StreamBuilder<List<dynamic>>(
        stream: DatabseService(St_uid: user!.uid).getData(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List all_notifs_rand = snapshot.data ?? [];
            all_notifs_rand
                .sort((a, b) => a.created_on.compareTo(b.created_on));
            List<dynamic> all_notifs;
            all_notifs = all_notifs_rand.reversed.toList();
            //all_notifs.sort((a, b) => a.created_on.compareTo(b.created_on));

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
                        for (var i in all_notifs) NotifItem(i)
                      ]),
                    ),
                  ),
                ),
              ),
            );
            /*
          }
          else if (snapshot.hasError) {
            print(snapshot.error);
            return Container(
              child: Center(child: Text("Error fetching notifications")),
            );
            */
          } else {
            print(snapshot.error);
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
