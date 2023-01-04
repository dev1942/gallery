import 'package:flutter/material.dart';

class SpinKitPulse extends StatefulWidget {
  final Color color;
  final double size;

  const SpinKitPulse({
    required Key key,
    required this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitPulseState createState() => _SpinKitPulseState();
}

class _SpinKitPulseState extends State<SpinKitPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurveTween(curve: Curves.easeInOut).animate(_controller)
      ..addListener(
        () => setState(() => <String, void>{}),
      );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 1.0 - _animation.value,
        child: Transform.scale(
          scale: _animation.value,
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.color),
          ),
        ),
      ),
    );
  }
}
