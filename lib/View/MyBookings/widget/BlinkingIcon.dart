import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';

class BlinkIcon extends StatefulWidget{
  @override
  _BlinkIconState createState() => _BlinkIconState();
}
class _BlinkIconState extends State<BlinkIcon> with SingleTickerProviderStateMixin{
  AnimationController ?_controller;
  Animation<Color>? _colorAnimation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1 ));
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
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Icon(Icons.whatsapp, size: 30, color: _colorAnimation!.value,);
      },
    );
  }
}