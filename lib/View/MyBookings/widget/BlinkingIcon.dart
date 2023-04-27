// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';

class BlinkIcon extends StatefulWidget {
  const BlinkIcon({Key? key}) : super(key: key);

  @override
  _BlinkIconState createState() => _BlinkIconState();
}

class _BlinkIconState extends State<BlinkIcon> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color>? _colorAnimation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _colorAnimation = ColorTween(begin: Colors.green, end: AppColors.colorYellowShade)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.linear)) as Animation<Color>?;
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller!.forward();
      }
      setState(() {});
    });
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Icon(
          Icons.chat,
          size: 25,
          color: _colorAnimation!.value,
        );
      },
    );
  }
}
