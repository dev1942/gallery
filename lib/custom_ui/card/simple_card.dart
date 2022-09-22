import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';

class SimpleCard extends StatelessWidget {
  final String lastNumber;
  final String holderName;
  final String expiryDate;
  final String brand;
  final Function onTap;
  const SimpleCard(
      {Key? key,
      required this.lastNumber,
      required this.holderName,
      required this.brand,
      required this.expiryDate,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
      width: double.infinity,
      decoration: AppViews.getGreyGradientBoxDecoration(mBorderRadius: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 60,
                child: ClipRRect(
                    child: Image.asset(brand.toLowerCase() == 'visa'
                        ? 'assets/images/visa.png'
                        : 'assets/images/mastercard.png')),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.colorWhite,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '••••',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Text('••••',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const Text(
                '••••',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                lastNumber,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder',
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.grayDashboardText,
                          fontSizeDelta: -2),
                    ),
                    Text(
                      holderName,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: Colors.white,
                          fontSizeDelta: 1.2),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expires',
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.grayDashboardText,
                        fontSizeDelta: -2),
                  ),
                  Text(
                    expiryDate,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: Colors.white,
                        fontSizeDelta: 1.2),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
