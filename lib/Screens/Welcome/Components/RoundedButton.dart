import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final Color color, textcolor;

  const RoundButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: color,
            primary: textcolor,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: press,
          child: Text(text),
        ),
      ),
    );
  }
}

class PressableSmallButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textcolor;

  const PressableSmallButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textcolor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final Color color, textcolor;

  const SmallButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: color,
            primary: textcolor,
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: press,
          child: Text(text),
        ),
      ),
    );
  }
}
