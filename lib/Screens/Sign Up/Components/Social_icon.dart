import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  //final VoidCallback? press;

  const SocialIcon({
    Key? key,
    required this.iconSrc,
    //required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(iconSrc),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
