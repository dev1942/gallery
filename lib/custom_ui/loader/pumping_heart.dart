import 'dart:math';

import 'package:flutter/material.dart';

class SpinKitPumpingHeart extends StatefulWidget {
  final Color color;
  final double size;

  const SpinKitPumpingHeart({
    required Key key,
    required this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitPumpingHeartState createState() => _SpinKitPumpingHeartState();
}

class _SpinKitPumpingHeartState extends State<SpinKitPumpingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400))
      ..repeat();
    _anim1 = Tween(begin: 1.0, end: 1.25).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 1.0, curve: MyCurve()),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _anim1,
      child: Icon(
        Icons.favorite,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}

class MyCurve extends Curve {
  @override
  double transform(double t) {
    if (t >= 0.0 && t < 0.22) {
      return pow(t, 1.0) * 4.54545454;
    } else if (t >= 0.22 && t < 0.44) {
      return 1.0 - (pow(t - 0.22, 1.0) * 4.54545454);
    } else if (t >= 0.44 && t < 0.5) {
      return 0.0;
    } else if (t >= 0.5 && t < 0.72) {
      return pow(t - 0.5, 1.0) * 2.27272727;
    } else if (t >= 0.72 && t < 0.94) {
      return 0.5 - (pow(t - 0.72, 1.0) * 2.27272727);
    } else {
      return 0.0;
    }
  }
}
