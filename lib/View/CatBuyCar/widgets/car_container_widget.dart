import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/Views/buy_car_detail_page.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';

import '../../../widgets/fade_in_image.dart';
import '../models/carsListModel.dart';

class CarItem extends StatelessWidget {
  final CarsForSell carsForSell;
  const CarItem({Key? key, required this.carsForSell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CarBuyDetailScreen(
              carsForSell: carsForSell,
            ));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(0.0, 1.0), blurRadius: 16),
        ]),
        child: Column(
          children: [
            NetworkImageCustom(
              image: carsForSell.image!.isEmpty ? "" : carsForSell.image!.first,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 0, top: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          carsForSell.title ?? "",
                          style: regularText(14).copyWith(color: HexColor('#4E5F76'), fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.selectButton,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          carsForSell.details?.newOrUsed!.toUpperCase() ?? "",
                          style: regularText(12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Text(
                      //   'Color ',
                      //   style: regularText(12).copyWith(color: AppColors.lightGrey),
                      // ),
                      Text(
                        carsForSell.details?.color!.toUpperCase() ?? "",
                        style: regularText(12).copyWith(color: AppColors.lightGrey, decoration: TextDecoration.underline),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Model: ${carsForSell.details?.model}" ?? "",
                            style: regularText(12).copyWith(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Price: ${carsForSell.details?.price} AED",
                            style: regularText(12).copyWith(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
