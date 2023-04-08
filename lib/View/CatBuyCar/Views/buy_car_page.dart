import 'package:flutter/material.dart';
import 'package:otobucks/View/CatBuyCar/Views/filter_car_page.dart';
import 'package:otobucks/View/CatBuyCar/widgets/car_container_widget.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/text_styles.dart';

class BuyCarScreen extends StatefulWidget {
  const BuyCarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyCarScreen> createState() => _BuyCarScreenState();
}

class _BuyCarScreenState extends State<BuyCarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Search Result',
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: ListView(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            width: double.infinity,
            height: AppDimens.dimens_60,
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [_nearByFilter(), _carList()],
          )
        ],
      ),
    );
  }

  _nearByFilter() => Row(
        children: [
          Text(
            'Nearby You',
            style: regularText(15),
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FilterAcarScreen()));
              },
              child: const Text(
                'Filters',
              ))
        ],
      );

  _carList() => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const CarItem();
      });
}
