import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../global/app_views.dart';

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
    return InkWell(
      onTap: (){onTap();},
      child: Container(
        height: Get.width * 0.99,
        margin: const EdgeInsets.only(
            left: AppDimens.dimens_10,
            right: AppDimens.dimens_10,
            bottom: AppDimens.dimens_5,
            top: AppDimens.dimens_5),
        child: Column(
          children: [
            //----------------------Image-----------------------------//
            Container(
              height: Get.width * 0.7,
              decoration: BoxDecoration(
                color: const Color(0xCC505561),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimens.dimens_20),topRight: Radius.circular(AppDimens.dimens_20)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
            ),
            addVerticleSpace(15),
            ListTile(
              isThreeLine: true,
              dense: true,
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: AppColors.colorYellowShade,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.category,color: Colors.white,size: 30,),
              ),
              title: Text(strTitle,style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16,fontWeight: FontWeight.bold),),
              subtitle: Text(strSubTitle,),
              trailing: InkWell(
                onTap: (){
                  onTap();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black)),
                  child: Text("OPEN".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ),

          ],
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.grayDashboardItem,
          borderRadius: BorderRadius.circular(AppDimens.dimens_20),
        ),
      ),
    );
  }
}
