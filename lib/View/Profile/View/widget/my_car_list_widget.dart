// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';

class MyCarListItem extends StatelessWidget {
  final String image;
  final String carBrand;
  final String modeYear;
  final String km;
  final String color;
  final String code;
  final String city;
  final String number;
  final bool isViewed;
  final Function() onEditTap;
  final Function() onDeleteTap;

  const MyCarListItem(
      {Key? key,
      this.isViewed = false,
      required this.carBrand,
      required this.modeYear,
      required this.km,
      required this.color,
      required this.image,
      required this.code,
      required this.city,
      required this.number,
      required this.onEditTap,
      required this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.dimens_5, top: AppDimens.dimens_5),
      padding: const EdgeInsets.all(AppDimens.dimens_20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(
              end: AppDimens.dimens_20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.dimens_10),
              child: Image.asset('assets/images/bmw2.png', height: AppDimens.dimens_70, width: AppDimens.dimens_80),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        carBrand.toUpperCase(),
                        style: AppStyle.textViewStyleNormalBodyText2(
                            context: context, color: AppColors.colorBlueStart, fontSizeDelta: 0, fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  const SizedBox(),
                  isViewed
                      ? const SizedBox()
                      : Row(
                          children: [
                            GestureDetector(onTap: onEditTap, child: const Icon(Icons.edit_calendar)),
                            GestureDetector(onTap: onDeleteTap, child: const Icon(Icons.delete)),
                          ],
                        ),
                ],
              ),

              addVerticleSpace(10),
              // row km color
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // column odel year
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Model",
                        style: AppStyle.textViewStyleSmall(context: context, color: Colors.red, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                      Text(
                        modeYear,
                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                    ],
                  ),
                  // column km
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "KM         ",
                        style: AppStyle.textViewStyleSmall(context: context, color: Colors.red, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                      Text(
                        km,
                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                    ],
                  ),
                  // column colo
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color     ",
                        style: AppStyle.textViewStyleSmall(context: context, color: Colors.red, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                      Text(
                        color,
                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 0),
                      ),
                    ],
                  ),
                ],
              ),

              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  codeCityNumber(context, "Code  ", code),
                  codeCityNumber(context, "City", city),
                  codeCityNumber(context, "Number", number),
                ],
              )
            ],
          ))
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.grayDashboardItem,
        borderRadius: BorderRadius.circular(AppDimens.dimens_12),
      ),
    );
  }

  Widget codeCityNumber(BuildContext context, heading, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorRED, fontSizeDelta: -2, fontWeightDelta: 0),
        ),
        const SizedBox(height: 3.0),
        Text(
          text.toString().toUpperCase(),
          style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 0),
        ),
      ],
    );
  }
}
