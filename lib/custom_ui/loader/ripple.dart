import 'package:flutter/material.dart';

class SpinKitRipple extends StatefulWidget {
  final Color color;
  final double size;

  const SpinKitRipple({
    required Key key,
    required this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitRippleState createState() => _SpinKitRippleState();
}

class _SpinKitRippleState extends State<SpinKitRipple>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat();

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.linear),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.linear),
      ),
    )..addListener(() => setState(() => <String, void>{}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 1.0 - _animation1.value,
            child: Transform.scale(
              scale: _animation1.value,
              child: Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color, width: 10.0),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 1.0 - _animation1.value,
            child: Transform.scale(
              scale: _animation2.value,
              child: Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color, width: 10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
