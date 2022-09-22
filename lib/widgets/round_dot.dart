import 'package:flutter/material.dart';

class RoundDot extends StatelessWidget {
  final double size;
  final Color mColor;

  const RoundDot({Key? key, required this.size, required this.mColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: mColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
