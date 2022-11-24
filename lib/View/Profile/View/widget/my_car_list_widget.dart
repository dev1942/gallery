import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../../../../global/app_images.dart';

class MyCarListItem extends StatelessWidget {
  final String image;
  final String carBrand;
  final String modeYear;
  final String km;
  final String color;
  final String code;
  final String city;
  final String number;
  final Function() onEditTap;
  final Function() onDeleteTap;

  const MyCarListItem(
      {Key? key,
        required this.carBrand,
        required this.modeYear,
        required this.km,
        required this.color,
        required this.image,
        required this.code,
        required this.city,
        required this.number,
        required this.onEditTap,
        required this.onDeleteTap

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: AppDimens.dimens_20,
          right: AppDimens.dimens_20,
          bottom: AppDimens.dimens_5,
          top: AppDimens.dimens_5),
      padding: const EdgeInsets.all(AppDimens.dimens_20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(
              end: AppDimens.dimens_20,
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.dimens_10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_10),
                child: NetworkImageCustom(
                    image: image,
                    height: AppDimens.dimens_70,
                    width: AppDimens.dimens_70),
              ),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Row(children: [
                       Text(
                         carBrand,
                         style: AppStyle.textViewStyleNormalBodyText2(
                             context: context,
                             color: AppColors.colorBlueStart,
                             fontSizeDelta: 0,
                             fontWeightDelta: 2),
                       ),
                       SizedBox(width: 10.0),
                       Text(
                         modeYear,
                         style: AppStyle.textViewStyleSmall(
                             context: context,
                             color: AppColors.colorBlack,
                             fontSizeDelta: -2,
                             fontWeightDelta: 0),
                       ),
                     ],),
                      Row(children: [
                        GestureDetector(
                          onTap: onEditTap,
                          child: Image.asset(
                              AppImages.ic_edit_profile_icon,
                              color: AppColors.colorBlack,
                              width: 18,
                              height: 18),
                        ),
                        SizedBox(width: 20.0),
                       GestureDetector(
                           onTap: onDeleteTap,
                           child: Icon(Icons.delete)),
                      ],)
                    ],
                  ),
                  Text(
                    "${km} KM",
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack,
                        fontSizeDelta: -2,
                        fontWeightDelta: 0),
                  ),

                  Text(
                    color,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack,
                        fontSizeDelta: -2,
                        fontWeightDelta: 0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    CodeCityNumber(context,"Code",code),
                    CodeCityNumber(context,"City",city),
                    CodeCityNumber(context,"Number",number),
                  ],)

                ],
              ))
        ],
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.grayDashboardItem,
        borderRadius: BorderRadius.circular(AppDimens.dimens_20),
      ),
    );
  }

  Widget CodeCityNumber(BuildContext context,heading,text){
    return   Column(
      children: [
        Text(
          heading,
          style: AppStyle.textViewStyleSmall(
              context: context,
              color: AppColors.colorRED,
              fontSizeDelta: -2,
              fontWeightDelta: 0),
        ),
        SizedBox(height:3.0),
        Text(
          text,
          style: AppStyle.textViewStyleSmall(
              context: context,
              color: AppColors.colorBlack,
              fontSizeDelta: -2,
              fontWeightDelta: 0),
        ),
      ],
    );
  }
}
