import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';

// All rights reserved by Healer

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final Color? color;
  final GestureTapCallback? onPress;
  final dynamic icon;
  final dynamic keys;
  final double buttonHight;

  const PrimaryButton({Key? key, required this.label, required this.onPress, required this.color, this.icon, this.keys, this.buttonHight = 45.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: buttonHight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPress,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: label,
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              elevation: MaterialStateProperty.all(4),
              backgroundColor: MaterialStateProperty.all(color ?? AppColors.colorPrimary),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
        ),
      );
}
