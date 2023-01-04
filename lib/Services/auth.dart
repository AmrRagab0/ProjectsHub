import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';
import '../Classes/Student.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // creating a custom student from a firebase user
  Student? _studentFromFirbaseUser(User user) {
    return user != null
        ? Student(
            uid: user.uid,
            First_name: user.displayName!,
            Last_name: user.displayName!,
            Email_address: user.email!,
            Profile_image: user.photoURL!,
          )
        : null;
  }

  // auth changes ('user logged in of signed out ')

  Stream<Student?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _studentFromFirbaseUser(user!));
    //.map(_studentFromFirbaseUser)
  }

  // sign in anynomous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _studentFromFirbaseUser(user as User);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  // sign in with Google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    DatabseService(St_uid: result.user!.uid).updateStudentData(
        result.user!.uid,
        result.user!.displayName!,
        result.user!.displayName!,
        result.user!.email!,
        result.user!.photoURL!, []);
    return _studentFromFirbaseUser(result.user!);
  }

  // sign up
  Future Register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //UserCredential userCredential = await FirebaseAuth.instance
      //.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _studentFromFirbaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
