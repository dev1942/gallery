import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../Controllers/accessories_sub_cat_controller.dart';
import '../Controllers/explore_screen_controller.dart';
import '../Widgets/item_component.dart';
import 'item_detail_screen.dart';

class ExploreAccessoriesScreen extends StatefulWidget {
  final String storeId;
  final String storeTitle;
  const ExploreAccessoriesScreen({Key? key, required this.storeId, required this.storeTitle}) : super(key: key);

  @override
  State<ExploreAccessoriesScreen> createState() => _ExploreAccessoriesScreenState();
}

class _ExploreAccessoriesScreenState extends State<ExploreAccessoriesScreen> {
  var controller = Get.put(StoreExploreController());

  @override
  void initState() {
    controller.getProductsByStore(widget.storeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.storeTitle,
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            width: double.infinity,
            height: AppDimens.dimens_60,
          ),
          Column(
            children: [
              _searchFiled(),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.colorBlueStart,
                ),
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index != 0 ? AppColors.colorBlueStart : Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          'Tires',
                          style: regularText600(13).copyWith(color: index == 0 ? AppColors.colorBlueStart : Colors.white),
                        ),
                      );
                    }),
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Text(
                    'Tires',
                    style: regularText600(17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Wrap(
                  //   children:
                  //       List.generate(4, (index) => const CartItemComponent()),
                  // ),
                  // Text(
                  //   'Carpets',
                  //   style: regularText600(ht(16)),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 10),
                  //   height: 230,
                  //   child: ListView.builder(
                  //       physics: const BouncingScrollPhysics(),
                  //       scrollDirection: Axis.horizontal,
                  //       shrinkWrap: true,
                  //       itemCount: 3,
                  //       itemBuilder: (context, index) {
                  //         return const CartItemComponent();
                  //       }),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   'Recommended Accessories',
                  //   style: regularText600(ht(16)),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  GetBuilder<StoreExploreController>(builder: (value) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 230,
                      child: AppViews.getSetData(
                          context,
                          value.mShowData,
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: value.products.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => ItemDetailsScreen(
                                          productModel: value.products[index],
                                        ));
                                  },
                                  child: CartItemComponent(
                                    productModel: value.products[index],
                                  ),
                                );
                              })),
                    );
                  }),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   'Popular Shopes',
                  //   style: regularText600(ht(16)),
                  // ),
                  // ListView.builder(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: 1,
                  //     itemBuilder: (context, index) {
                  //       return  ShopItemComponent();
                  //     }),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  cartItem() {
    return AspectRatio(
      aspectRatio: 0.8,
      child: InkWell(
        onTap: () {
          // Get.to(() => const ItemDetailsScreen());
        },
        child: Container(
          padding: EdgeInsets.all(wd(12)),
          decoration: ContainerProperties.shadowDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/ic_facebook.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: wd(10),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$50', maxLines: 1, style: subHeadingText(wd(16))),
                          Text(
                            'Company',
                            maxLines: 1,
                            style: headingText(wd(13)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: wd(8),
              ),
              Text(
                'Lorem Ipsum is simply dummy text of the printing.',
                style: lightText(wd(13)),
              ),
              SizedBox(
                height: wd(8),
              ),
              Container(
                alignment: Alignment.center,
                height: wd(55),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 100,
                      height: wd(35),
                      child: PrimaryButton(
                        label: const Text('Add to cart'),
                        onPress: () {},
                        color: null,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _searchFiled() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: AppDimens.dimens_20, bottom: AppDimens.dimens_6, right: AppDimens.dimens_10, top: AppDimens.dimens_6),
      child: CustomTextFieldWithIcon(
        textInputAction: TextInputAction.next,
        enabled: true,
        controller: Get.find<AccessoriesSubCatController>().searchController,
        keyboardType: TextInputType.text,
        hintText: Constants.STR_SEARCH,
        inputFormatters: const [],
        obscureText: false,
        height: AppDimens.dimens_36,
        onChanged: (String value) {},
        onSubmit: (String value) {},
        suffixIcon: InkWell(
          child: Image.asset(
            AppImages.ic_search,
            width: AppDimens.dimens_18,
            // color: AppColors.colorIconGray,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
