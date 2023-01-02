import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class SpinKitDualRing extends StatefulWidget {
  final Color color;
  final double size;

  const SpinKitDualRing({
    required Key key,
    required this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitDualRingState createState() => _SpinKitDualRingState();
}

class _SpinKitDualRingState extends State<SpinKitDualRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
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
      ..rotateZ((_animation1.value) * math.pi * 2);
    return Center(
      child: Transform(
        transform: transform,
        alignment: FractionalOffset.center,
        child: CustomPaint(
          child: SizedBox(
            height: widget.size,
            width: widget.size,
          ),
          painter: _DualRingPainter(color: widget.color),
        ),
      ),
    );
  }
}

class _DualRingPainter extends CustomPainter {
  Paint p = Paint();
  double weight = 90.0;

  _DualRingPainter({required Color color}) {
    p.color = color;
    p.strokeWidth = 10.0;
    p.style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
      0.0,
      getRadian(weight),
      false,
      p,
    );
    canvas.drawArc(
      Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
      getRadian(180.0),
      getRadian(weight),
      false,
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double getRadian(double angle) {
    return math.pi / 180 * angle;
  }
}
