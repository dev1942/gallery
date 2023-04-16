import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/Views/filter_car_page.dart';
import 'package:otobucks/View/CatBuyCar/widgets/car_container_widget.dart';
import 'package:otobucks/global/app_views.dart';

import '../controllers/buy_car_controller.dart';

class BuyCarScreen extends StatefulWidget {
  const BuyCarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyCarScreen> createState() => _BuyCarScreenState();
}

class _BuyCarScreenState extends State<BuyCarScreen> {
  var controller = Get.put(BuyCarController());
  @override
  void initState() {
    super.initState();
    controller.getCarsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Obx(() => AppViews.getSetData(context, controller.mShowData.value, mShowWidget(controller))));
  }

  Widget mShowWidget(BuyCarController controller) {
    return Column(
      children: [
        Row(
          children: [
            // Text(
            //   'Nearby You',
            //   style: regularText(15),
            // ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FilterAcarScreen()));
                },
                child: const Text(
                  'Filters',
                ))
          ],
        ),
        ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.carsListModel == null || controller.carsListModel?.result == null ? 0 : controller.carsListModel!.result!.length,
            itemBuilder: (context, index) {
              return CarItem(
                carsForSell: controller.carsListModel!.result![index],
              );
            })
      ],
    );
  }
}
