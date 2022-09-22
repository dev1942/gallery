import 'package:flutter/material.dart';

import '../global/app_colors.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.colorBlueEnd,
            AppColors.colorBlueStart,
          ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text,
          maxLines: maxLines,
          overflow: TextOverflow.visible,
          textScaleFactor: 1,
          textAlign: textAlign,
          style: style),
    );
    // Use
    // GradientText(
    //   'Hello Flutter',
    //   style: const TextStyle(fontSize: 40),
    //   gradient: LinearGradient(colors: [
    //     Colors.blue.shade400,
    //     Colors.blue.shade900,
    //   ]),
    // ),
  }
}
