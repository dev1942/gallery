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
      child: Material(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 15),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: ContainerProperties.shadowDecoration(radius: 5.0, blurRadius: 10.0).copyWith(color: AppColors.colorWhite),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 45),
                      child: NetworkImageCustom(
                        image: carsForSell.image!.isEmpty ? "" : carsForSell.image!.first,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.selectButton,
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          carsForSell.details?.newOrUsed!.toUpperCase() ?? "",
                          style: regularText(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            carsForSell.title ?? "",
                            style: regularText(14).copyWith(color: HexColor('#4E5F76')),
                          ),
                        ),
                        Text(
                          carsForSell.details?.topSpeed ?? "",
                          style: regularText(14).copyWith(color: AppColors.colorBlueStart),
                        ),
                        Text(
                          "/hour",
                          style: regularText(14).copyWith(color: AppColors.lightGrey),
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
                            alignment: Alignment.centerRight,
                            child: Text(
                              carsForSell.details?.model ?? "",
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
      ),
    );
  }
}
