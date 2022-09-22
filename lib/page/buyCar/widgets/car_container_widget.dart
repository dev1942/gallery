import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/page/buyCar/buy_car_detail_page.dart';

class CarItem extends StatelessWidget {
  const CarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const CarBuyDetailScreen());
      },
      child: Material(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 15),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: ContainerProperties.shadowDecoration(
                  radius: 5.0, blurRadius: 10.0)
              .copyWith(color: AppColors.colorWhite),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/bmw1.png',
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                      top: 12,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.selectButton,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          'near 2km',
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
                            'BMW 8 series',
                            style: regularText(14)
                                .copyWith(color: HexColor('#4E5F76')),
                          ),
                        ),
                        Text(
                          '130',
                          style: regularText(14)
                              .copyWith(color: AppColors.colorBlueStart),
                        ),
                        Text(
                          '/hour',
                          style: regularText(14)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: AppColors.colorOrange,
                        ),
                        Text(
                          ' 4.0 ',
                          style: regularText(12)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                        Text(
                          '(58 Reviews)',
                          style: regularText(12).copyWith(
                              color: AppColors.lightGrey,
                              decoration: TextDecoration.underline),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Lahore, Pakistan',
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
