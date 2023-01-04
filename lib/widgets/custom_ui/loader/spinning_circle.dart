import 'dart:math';

import 'package:flutter/widgets.dart';

class SpinKitSpinningCircle extends StatefulWidget {
  final Color color;
  final BoxShape shape;
  final double size;

  const SpinKitSpinningCircle({
    required Key key,
    required this.color,
    this.shape = BoxShape.circle,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitSpinningCircleState createState() => _SpinKitSpinningCircleState();
}

class _SpinKitSpinningCircleState extends State<SpinKitSpinningCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animation1 = Tween(begin: 0.0, end: 7.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.identity()
      ..rotateY((0 - _animation1.value) * pi);
    return Center(
      child: Transform(
        transform: transform,
        alignment: FractionalOffset.center,
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(shape: widget.shape, color: widget.color),
        ),
      ),
    );
  }
}
