import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/widgets/round_dot.dart';

class ThumbIcon extends StatelessWidget {
  const ThumbIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(3.5),
      width: 30,
      decoration:
          ContainerProperties.shadowDecoration(radius: 100.0, blurRadius: 14.0)
              .copyWith(color: AppColors.grayDashboardItem),
      child: Container(
        height: 30,
        padding: const EdgeInsets.all(2),
        width: 30,
        decoration: ContainerProperties.shadowDecoration(
                radius: 100.0, blurRadius: 14.0)
            .copyWith(color: AppColors.colorWhite),
        child: RoundDot(
          mColor: AppColors.colorBlueStart,
          size: 20,
        ),
      ),
    );
  }
}
