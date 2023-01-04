import 'package:flutter/widgets.dart';
import 'package:otobucks/widgets/custom_ui/loader/utils.dart';

class SpinKitFadingGrid extends StatefulWidget {
  final Color color;
  final BoxShape shape;
  final double size;

  const SpinKitFadingGrid({
    required Key key,
    required this.color,
    this.shape = BoxShape.circle,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _SpinKitFadingGridState createState() => _SpinKitFadingGridState();
}

class _SpinKitFadingGridState extends State<SpinKitFadingGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        // ignore: prefer_const_constructors
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _circle(1),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(1),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: widget.size / 8,
                width: widget.size,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _circle(4),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(1),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: widget.size / 8,
                width: widget.size,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _circle(4),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(3),
              SizedBox(
                width: widget.size / 8,
              ),
              _circle(3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circle(int i) {
    return FadeTransition(
      opacity: DelayTween(begin: 0.4, end: 0.9, delay: 0.3 * (i - 1))
          .animate(_controller),
      child: Container(
        height: widget.size / 4,
        width: widget.size / 4,
        decoration: BoxDecoration(shape: widget.shape, color: widget.color),
      ),
    );
  }
}
