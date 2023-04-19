import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/Views/rent_acar_date_selection.dart';
import 'package:otobucks/View/CatBuyCar/controllers/buy_car_controller.dart';
import 'package:otobucks/global/app_colors.dart';

import '../../../global/app_views.dart';
import '../../../widgets/custom_textfield_with_icon.dart';
import '../../../widgets/small_button.dart';

class FilterAcarScreen extends StatefulWidget {
  const FilterAcarScreen({Key? key}) : super(key: key);

  @override
  State<FilterAcarScreen> createState() => _FilterAcarScreenState();
}

final txtBrand = TextEditingController();
final txtModelYear = TextEditingController();
String minPrice = "";
String maxPrice = "";
String transmissionype = "";
bool isNew = false;
bool isUsed = false;
bool isManual = false;
bool isAuto = false;

class _FilterAcarScreenState extends State<FilterAcarScreen> {
  RangeValues values = RangeValues(10000, 10000000);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppViews.initAppBar(
          mContext: context,
          centerTitle: false,
          strTitle: 'Filter cars',
          isShowNotification: true,
          isShowSOS: true,
        ),
        body: GetBuilder<BuyCarController>(
            init: BuyCarController(),
            builder: (value) => Stack(
                  children: [
                    GetBuilder<BuyCarController>(
                      builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        // mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 50,
                                width: size.width * 0.4,
                                child: PrimaryButton(
                                  buttonHight: 50,
                                  label: Text(
                                    'New Car',
                                    style: TextStyle(color: isNew ? Colors.white : AppColors.colorPrimary),
                                  ),
                                  color: isNew ? null : Colors.white,
                                  onPress: () {
                                    setState(() {
                                      isNew = true;
                                      isUsed = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: size.width * 0.4,
                                child: PrimaryButton(
                                  label: Text(
                                    'Used Car',
                                    style: TextStyle(color: isUsed ? Colors.white : AppColors.colorPrimary),
                                  ),
                                  color: isUsed ? null : Colors.white,
                                  onPress: () {
                                    setState(() {
                                      isUsed = true;
                                      isNew = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFieldWithIcon(
                            height: 42,
                            textInputAction: TextInputAction.next,
                            enabled: true,
                            controller: txtBrand,
                            keyboardType: TextInputType.text,
                            hintText: "Brand".tr,
                            inputFormatters: const [],
                            obscureText: false,
                            onChanged: (String value) {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFieldWithIcon(
                            height: 42,
                            textInputAction: TextInputAction.next,
                            enabled: true,
                            controller: txtBrand,
                            keyboardType: TextInputType.text,
                            hintText: "Model Year".tr,
                            inputFormatters: const [],
                            obscureText: false,
                            onChanged: (String value) {},
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Car Company',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 60,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 5,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => SizedBox(
                          //       // margin: EdgeInsets.only(right: 10),
                          //       height: 60,
                          //       width: size.width * 0.4,
                          //       child: PrimaryButton(
                          //         label: const Text(
                          //           'BMW',
                          //           style: TextStyle(color: Colors.black),
                          //         ),
                          //         color: Colors.white,
                          //         onPress: () {},
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Car Model',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 60,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 5,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => SizedBox(
                          //       // margin: EdgeInsets.only(right: 10),
                          //       height: 60,
                          //       width: size.width * 0.4,
                          //       child: PrimaryButton(
                          //         label: const Text(
                          //           'X6(G06)',
                          //           style: TextStyle(color: Colors.black),
                          //         ),
                          //         color: Colors.white,
                          //         onPress: () {},
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Model year',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 60,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 5,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => SizedBox(
                          //       // margin: EdgeInsets.only(right: 10),
                          //       height: 60,
                          //       width: size.width * 0.4,
                          //       child: PrimaryButton(
                          //         label: const Text(
                          //           '2016',
                          //           style: TextStyle(color: Colors.black),
                          //         ),
                          //         color: Colors.white,
                          //         onPress: () {},
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Car color',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 60,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 5,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => Container(
                          //       // margin: EdgeInsets.only(right: 10),
                          //       height: 60,
                          //       width: size.width * 0.2,
                          //       decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Price Range',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          RangeSlider(
                              activeColor: Theme.of(context).primaryColor,
                              inactiveColor: Colors.grey[300],
                              // divisions: 5,
                              min: 10000,
                              max: 10000000,
                              values: values,
                              onChanged: (value) {
                                setState(() {
                                  values = value;
                                  minPrice = values.start.toInt().toString();
                                  maxPrice = value.end.toInt().toString();
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Millage Range',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // RangeSlider(
                          //     activeColor: Theme.of(context).primaryColor,
                          //     inactiveColor: Colors.grey[300],
                          //     divisions: 5,
                          //     min: 1,
                          //     max: 100,
                          //     values: values,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         values = value;
                          //       });
                          //     }),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Body Type',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 100,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 10,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => Material(
                          //       borderRadius: BorderRadius.circular(9),
                          //       elevation: 2,
                          //       child: Container(
                          //         // margin: EdgeInsets.only(right: 10),

                          //         width: size.width * 0.18,
                          //         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          //         child: Column(
                          //           children: [
                          //             Image.network(
                          //               "https://www.iconpacks.net/icons/1/free-car-icon-1057-thumb.png",
                          //               color: Colors.grey,
                          //             ),
                          //             const Text("Sedan")
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Transmission Type',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 50,
                                width: size.width * 0.4,
                                child: PrimaryButton(
                                  buttonHight: 50,
                                  label: Text(
                                    'Automatic',
                                    style: TextStyle(color: isAuto ? Colors.white : AppColors.colorPrimary),
                                  ),
                                  color: isAuto ? null : AppColors.colorWhite,
                                  onPress: () {
                                    setState(() {
                                      isAuto = true;
                                      isManual = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: size.width * 0.4,
                                child: PrimaryButton(
                                  label: Text('Manual', style: TextStyle(color: isManual ? Colors.white : AppColors.colorPrimary)),
                                  color: isManual ? null : AppColors.colorWhite,
                                  onPress: () {
                                    setState(() {
                                      isManual = true;
                                      isAuto = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     'Fuel type',
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // SizedBox(
                          //   height: 60,
                          //   child: ListView.separated(
                          //     separatorBuilder: (context, index) => const SizedBox(
                          //       width: 5,
                          //     ),
                          //     itemCount: 4,
                          //     padding: const EdgeInsets.all(4),
                          //     // shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => SizedBox(
                          //       // margin: EdgeInsets.only(right: 10),
                          //       height: 60,
                          //       width: size.width * 0.4,
                          //       child: PrimaryButton(
                          //         label: const Text(
                          //           'Petrol',
                          //           style: TextStyle(color: Colors.black),
                          //         ),
                          //         color: Colors.white,
                          //         onPress: () {},
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),

                          SizedBox(
                            // margin: EdgeInsets.only(right: 10),
                            height: 60,
                            width: size.width * 0.4,
                            child: PrimaryButton(
                              label: const Text(
                                'Apply Filters',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: null,
                              onPress: () {
                                value.filterCarsTask(context,
                                    condition: "",
                                    brand: txtBrand.text,
                                    modelYear: txtModelYear.text,
                                    minPrice: minPrice,
                                    maxPrice: maxPrice,
                                    transmissiontype: (isAuto == false && isManual == false)
                                        ? ""
                                        : isAuto == true
                                            ? "automatic"
                                            : "manual");
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          SizedBox(
                            // margin: EdgeInsets.only(right: 10),
                            height: 60,
                            width: size.width * 0.4,
                            child: PrimaryButton(
                              label: const Text(
                                'Clear Filters',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: null,
                              onPress: () {
                                value.filterCarsTask(context,
                                    condition: "", brand: "", modelYear: "", minPrice: "", maxPrice: "", transmissiontype: "");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
  }
}
