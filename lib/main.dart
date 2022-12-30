import 'package:flutter/material.dart';
import 'package:projectshub1/Screens/HomeScreen/HomeScreen.dart';
import 'package:projectshub1/Screens/Login/login.dart';
import 'package:projectshub1/Screens/Menu/Menu.dart';
import 'package:projectshub1/Screens/New%20Project/NewProjectScreen.dart';
import 'package:projectshub1/Screens/Profile/profile.dart';
import 'package:projectshub1/Screens/Project/ProjectScreen.dart';
import 'package:projectshub1/Screens/Sign%20Up/SignUp_Screen.dart';
import 'package:projectshub1/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectshub1/Screens/Wrapper.dart';
import 'package:projectshub1/Services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'Classes/Student.dart';

// ...

void main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  //void main() => runApp(MaterialApp(home: FooClass(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Student?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService()
          .user, // setting which stream you are going to be listening to
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome',
        theme: ThemeData(
            primaryColor: Colors.black, scaffoldBackgroundColor: Colors.white),
        home: Wrapper(),
      ),
    );
  }
}
