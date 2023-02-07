import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/Notifications/NotificationItem.dart';
import 'package:projectshub1/Screens/Project/components.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            NotifItem(),
            NotifItem(),
            NotifItem(),
            NotifItem(),
          ]),
        ),
      ),
    );
  }
}
