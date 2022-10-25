import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String strTitle;
  final String strSubTitle;
  final Function onTap;

  const CategoryItem(
      {Key? key,
      required this.strTitle,
      required this.strSubTitle,
      required this.image,
      required this.onTap})
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
      child: InkResponse(
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
                Text(
                  strTitle,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.colorBlueStart,
                      fontSizeDelta: 0,
                      fontWeightDelta: 2),
                ),
                Container(
                    margin: const EdgeInsets.only(top: AppDimens.dimens_10),
                    child: Text(
                      strSubTitle,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.grayDashboardText,
                          fontSizeDelta: -2,
                          fontWeightDelta: 0),
                    )),
              ],
            ))
          ],
        ),
        onTap: () {
          onTap();
        },
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.grayDashboardItem,
        borderRadius: BorderRadius.circular(AppDimens.dimens_20),
      ),
    );
  }
}
