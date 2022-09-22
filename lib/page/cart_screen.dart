import 'package:flutter/material.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/cart_component.dart';
import 'package:otobucks/widgets/small_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  int activeTabIndex = 0;

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                width: double.infinity,
                height: AppDimens.dimens_170,
              ),
              ListView(
                padding: const EdgeInsets.all(15),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const CartComponent();
                      }),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: ContainerProperties.simpleDecoration()
                        .copyWith(color: AppColors.grayDashboardItem),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Promo Code',
                            style: regularText(15)
                                .copyWith(color: AppColors.colorGray3),
                          ),
                        ),
                        Container(
                          width: wd(150),
                          decoration: ContainerProperties.shadowDecoration(),
                          child: const TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: PrimaryButton(
                              label: Text(
                                'Pickup',
                                style: regularText(17)
                                    .copyWith(color: Colors.white),
                              ),
                              onPress: () {},
                              color: null),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: PrimaryButton(
                              label: Text(
                                'Pickup',
                                style: regularText(17),
                              ),
                              onPress: () {},
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Date',
                    style: regularText(15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: ContainerProperties.simpleDecoration().copyWith(
                        border: Border.all(color: AppColors.colorGray6)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select date',
                            style: regularText(14)
                                .copyWith(color: AppColors.colorGray5),
                          ),
                        ),
                        const Icon(Icons.calendar_month)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: AppColors.colorGray5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subtotal',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tax (%)',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Delivery',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$50',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$10',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$20',
                                style: regularText(14)
                                    .copyWith(color: AppColors.colorGray5),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                      label: Text(
                        'Buy Now',
                        style: regularText600(17).copyWith(color: Colors.white),
                      ),
                      onPress: () {
                        // Get.to(() => CheckoutScreen());
                      },
                      color: null)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
