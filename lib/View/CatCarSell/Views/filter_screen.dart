import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:otobucks/View/CatBuyCar/Views/buy_car_page.dart';
import 'package:otobucks/View/CatCarSell/Widgets/thum_icon_slider.dart';
import 'package:otobucks/View/CatCarSell/Controllers/filter_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/round_dot.dart';
import 'package:otobucks/widgets/small_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CarSellFilters extends StatefulWidget {
  const CarSellFilters({Key? key}) : super(key: key);

  @override
  State<CarSellFilters> createState() => _CarSellFiltersState();
}

class _CarSellFiltersState extends State<CarSellFilters> {
  var _values = const SfRangeValues(0, 20);

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Global.inProgressAlert(Get.overlayContext!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _skipButtonText(),
          _usedNewOption(),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _carCompany(),
                _carModel(),
                _carYear(),
                _carColor(),
                _priceRange(),
                _mileageRaange(),
                _bodyType(),
                _transmissionTypeOption(),
                _fuelType(),
                _applyButton()
              ],
            ),
          )
        ]);
  }

  _skipButtonText() => Align(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () {},
          child: Text(
            'Skip Filters',
            style: subHeadingText(13).copyWith(
                color: AppColors.colorBlueStart,
                decoration: TextDecoration.underline),
          )));

  _usedNewOption() => GetBuilder<FilterScreenController>(
      init: FilterScreenController(),
      builder: (value) {
        return Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () => value.changeCarType(CarType.newCar),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: ContainerProperties.shadowDecoration(
                        blurRadius: 15.0, radius: 12.0)
                    .copyWith(
                        color: value.newCar
                            ? AppColors.colorBlueStart
                            : AppColors.colorWhite),
                child: Text(
                  'New Car',
                  style: regularText(17).copyWith(
                      color: value.newCar
                          ? AppColors.colorWhite
                          : AppColors.colorBlueStart),
                ),
              ),
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: InkWell(
              onTap: () => value.changeCarType(CarType.oldCar),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: ContainerProperties.shadowDecoration(
                        blurRadius: 15.0, radius: 12.0)
                    .copyWith(
                        color: !value.newCar
                            ? AppColors.colorBlueStart
                            : AppColors.colorWhite),
                child: Text(
                  'Used Car',
                  style: regularText(17).copyWith(
                      color: !value.newCar
                          ? AppColors.colorWhite
                          : AppColors.colorBlueStart),
                ),
              ),
            )),
          ],
        );
      });

  _carCompany() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Car Company',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.carCompanies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          value.changeCompany(value.carCompanies[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color: value.selectedCompany ==
                                        value.carCompanies[index]
                                    ? AppColors.selectButton
                                    : AppColors.colorWhite),
                        child: Text(
                          value.carCompanies[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
        ],
      );
  _carModel() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Car Model',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.carModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value.changeModel(value.carModel[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color:
                                    value.selectedModel == value.carModel[index]
                                        ? AppColors.selectButton
                                        : AppColors.colorWhite),
                        child: Text(
                          value.carModel[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      );
  _carYear() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Car Year',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.carYear.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value.changeYear(value.carYear[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color:
                                    value.selectedYear == value.carYear[index]
                                        ? AppColors.selectButton
                                        : AppColors.colorWhite),
                        child: Text(
                          value.carYear[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      );
  _bodyType() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Body Type',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.bodyType.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value.changeBodyType(value.bodyType[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 90,
                        width: 90,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color: value.selectedBodyType ==
                                        value.bodyType[index]
                                    ? AppColors.selectButton
                                    : AppColors.colorWhite),
                        child: Text(
                          value.bodyType[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  _carColor() => GetBuilder<FilterScreenController>(builder: (value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Car Color',
                  style: regularText(15),
                ),
                const SizedBox(
                  width: 7,
                ),
                RoundDot(mColor: value.selectedColor, size: AppDimens.dimens_10)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.carColors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value.changeColor(value.carColors[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        width: 70,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: value.carColors[index] ==
                                        value.selectedColor
                                    ? 0.0
                                    : 8.0,
                                radius: 12.0)
                            .copyWith(color: value.carColors[index]),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      });

  _priceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: regularText(15),
        ),
        const SizedBox(
          height: 8,
        ),
        GetBuilder<FilterScreenController>(builder: (value) {
          return SizedBox(
            height: 65,
            child: SfRangeSlider(
              min: 0.0,
              max: 100.0,
              values: _values,
              interval: 20,
              showTicks: false,
              showLabels: true,
             // showDividers: true,
              enableIntervalSelection: true,
              stepSize: 20,
              startThumbIcon: const ThumbIcon(),
              inactiveColor: HexColor('#4D0E4A86'),
              activeColor: HexColor('#4D0E4A86'),
              enableTooltip: false,
              numberFormat: i.NumberFormat("\$"),
              minorTicksPerInterval: 0,
             // edgeLabelPlacement: EdgeLabelPlacement.auto,
              endThumbIcon: const ThumbIcon(),
              onChanged: (SfRangeValues values) {
                setState(() {
                  _values = values;
                });
              },
            ),
          );
        }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _mileageRaange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mileage Range',
          style: regularText(15),
        ),
        const SizedBox(
          height: 8,
        ),
        GetBuilder<FilterScreenController>(builder: (value) {
          return SizedBox(
            height: 65,
            child: SfRangeSlider(
              min: 0.0,
              max: 100.0,
              values: _values,
              interval: 20,
              showTicks: false,
              showLabels: true,
             // showDividers: true,
              startThumbIcon: const ThumbIcon(),
              inactiveColor: HexColor('#4D0E4A86'),
              activeColor: HexColor('#4D0E4A86'),
              enableTooltip: false,
              minorTicksPerInterval: 0,
              //edgeLabelPlacement: EdgeLabelPlacement.auto,
              endThumbIcon: const ThumbIcon(),
              onChanged: (SfRangeValues values) {
                setState(() {
                  _values = values;
                });
              },
            ),
          );
        }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _transmissionTypeOption() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Transmission Type',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.transmissionTypes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value
                          .changeTransmission(value.transmissionTypes[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color: value.selectedCompany ==
                                        value.transmissionTypes[index]
                                    ? AppColors.selectButton
                                    : AppColors.colorWhite),
                        child: Text(
                          value.transmissionTypes[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
        ],
      );
  _fuelType() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Fuel Type',
            style: regularText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<FilterScreenController>(builder: (value) {
            return SizedBox(
              height: 65,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.fuelType.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => value.changeFuelType(value.fuelType[index]),
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, bottom: 10, left: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: ContainerProperties.shadowDecoration(
                                blurRadius: 8.0, radius: 12.0)
                            .copyWith(
                                color: value.selectedCompany ==
                                        value.fuelType[index]
                                    ? AppColors.selectButton
                                    : AppColors.colorWhite),
                        child: Text(
                          value.fuelType[index],
                          style: regularText(13)
                              .copyWith(color: AppColors.lightGrey),
                        ),
                      ),
                    );
                  }),
            );
          }),
        ],
      );

  _applyButton() => Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 45,
        child: PrimaryButton(
          label: const Text('Apply Filters'),
          onPress: () => Get.to(() => const BuyCarScreen()),
          color: null,
        ),
      );
}
