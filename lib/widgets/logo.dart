import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;

  Logo({required this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(
        'assets/logo2.png',
      ),
      height: height,
    );
  }
}
