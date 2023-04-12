import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/Views/inquiry_screen.dart';
import 'package:otobucks/View/CatBuyCar/widgets/read_more_widget.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/round_dot.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../models/carsListModel.dart';

class CarBuyDetailScreen extends StatefulWidget {
  final CarsForSell carsForSell;
  const CarBuyDetailScreen({Key? key, required this.carsForSell}) : super(key: key);

  @override
  CarBuyDetailScreenState createState() => CarBuyDetailScreenState();
}

class CarBuyDetailScreenState extends State<CarBuyDetailScreen> {
  List<String> cars = ['bmw1', 'bmw2'];
  List<String> carSpecification = ['Manual', 'Automatic', '4 seater', 'Sedan', '1000cc'];

  int selectedPage = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: _appBar(),
            backgroundColor: AppColors.getMainBgColor(),
            body: ListView(
              children: [
                // ListView(
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   children: [_topProfileContent()],
                // ),
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_pageView(), _pageViewDots(), _carDetails(), _specifications(), _overview(), _enquiryButton()],
                )
              ],
            )));
  }

  _selectedRoundWidget() => Container(
        height: 13,
        width: 13,
        decoration: ContainerProperties.simpleDecoration(radius: 100.0).copyWith(color: AppColors.colorBlueStart),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 13,
          width: 13,
          decoration: ContainerProperties.simpleDecoration(radius: 100.0).copyWith(color: AppColors.colorWhite),
          child: Container(
            margin: const EdgeInsets.all(1),
            height: 13,
            width: 13,
            decoration: ContainerProperties.simpleDecoration(radius: 100.0).copyWith(color: AppColors.colorBlueStart),
          ),
        ),
      );

  _appBar() => AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Car Detail Page',
        isShowNotification: true,
        isShowSOS: true,
      );

  _topProfileContent() => Container(
        padding: const EdgeInsets.only(left: AppDimens.dimens_50, top: AppDimens.dimens_25, bottom: AppDimens.dimens_32),
        alignment: Alignment.center,
        color: AppColors.colorBlueStart,
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_50),
                child: NetworkImageCustom(
                    image: Get.find<HomeScreenController>().image, fit: BoxFit.fill, height: AppDimens.dimens_60, width: AppDimens.dimens_60),
              ),
              margin: const EdgeInsets.only(right: AppDimens.dimens_10),
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_5, bottom: AppDimens.dimens_2),
                    child: Text(
                      Get.find<HomeScreenController>().fullName,
                      style:
                          AppStyle.textViewStyleNormalBodyText2(context: context, color: AppColors.colorWhite, fontSizeDelta: 0, fontWeightDelta: 0),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Car Owner",
                      style: AppStyle.textViewStyleSmall(
                          context: context, color: AppColors.colorWhite.withOpacity(0.7), fontSizeDelta: -2, fontWeightDelta: 0),
                    )),
              ],
            )),
          ],
        ),
      );

  _pageView() => SizedBox(
        height: 200,
        child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                selectedPage = index;
              });
            },
            controller: pageController,
            itemCount: widget.carsForSell.image!.isEmpty ? 0 : widget.carsForSell.image!.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  widget.carsForSell.image![index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text("Invalid Image"),
                  ),
                ),
              );
            }),
      );

  _pageViewDots() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            widget.carsForSell.image!.isEmpty ? 0 : widget.carsForSell.image!.length,
            (index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: index == selectedPage ? _selectedRoundWidget() : RoundDot(size: 8, mColor: AppColors.colorBlueStart.withOpacity(0.3)),
                )),
      );

  _carDetails() => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.carsForSell.details?.model ?? "",
                    style: regularText(14).copyWith(color: HexColor('#4E5F76')),
                  ),
                ),
                Text(
                  'Seats: ',
                  style: regularText(14).copyWith(color: AppColors.colorBlueStart),
                ),
                Text(
                  widget.carsForSell.details?.numberOfSeats ?? "",
                  style: regularText(14).copyWith(color: AppColors.lightGrey),
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
                  style: regularText(12).copyWith(color: AppColors.lightGrey),
                ),
                Text(
                  '(58 Reviews)',
                  style: regularText(12).copyWith(color: AppColors.lightGrey, decoration: TextDecoration.underline),
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
      );
  _specifications() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Car Specifications',
            style: subHeadingText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.gas_meter_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.transmissionType ?? "")
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.speed),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.topSpeed ?? "")
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.backpack_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.airBags == true ? "Yes" : "No")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.engineering_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.engine ?? "")
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_gas_station_outlined),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.fuelType ?? "")
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.color_lens),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.carsForSell.details!.color ?? "")
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          // Wrap(
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: List.generate(carSpecification.length, (index) {
          //     return ;
          //   }),
          // )
        ],
      );
  _overview() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Overview',
            style: subHeadingText(15),
          ),
          const SizedBox(
            height: 8,
          ),
          ExpandableText(widget.carsForSell.description ?? "")
        ],
      );
  _enquiryButton() => Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 45,
        child: PrimaryButton(
          label: const Text('Send Enquiry'),
          onPress: () => Get.to(() => const InquiryFormScreenCarBuy()),
          color: null,
        ),
      );
}
