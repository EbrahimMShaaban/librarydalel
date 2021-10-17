// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({required this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        'assets/logo3.png',
      ),
      height: height,
    );
  }
}
