import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: const Color(0xFF1A1A3F),
          size: 200,
        ),
      ),
    );
  }
}
