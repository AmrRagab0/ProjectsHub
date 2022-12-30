import 'package:flutter/material.dart';

class HaveAnAccount extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const HaveAnAccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Text(
          login ? "Don't have an account? " : "Already Have an account ? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign in",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
