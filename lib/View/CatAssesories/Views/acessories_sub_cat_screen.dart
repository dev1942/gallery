import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Dashboard/Controllers/dashboard_controller.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/global.dart';
import '../Controllers/accessories_sub_cat_controller.dart';
import '../Widgets/searched_products.dart';
import '../Widgets/shop_item_component.dart';

class AccessoriesSubCatScreen extends StatefulWidget {
  const AccessoriesSubCatScreen({Key? key}) : super(key: key);

  @override
  State<AccessoriesSubCatScreen> createState() => _AccessoriesSubCatScreenState();
}

class _AccessoriesSubCatScreenState extends State<AccessoriesSubCatScreen> {
  var controller = Get.put(AccessoriesSubCatController());

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   Global.inProgressAlert(Get.overlayContext!);
    // });
    if (controller.stores.isEmpty) {
      controller.getStores();
    }

    Get.find<DashboardController>().controllerSearch.addListener(() {
      controller.onChangeSearch(Get.find<DashboardController>().controllerSearch.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccessoriesSubCatController>(
        init: AccessoriesSubCatController(),
        builder: (value) {
          return value.showSearch
              ? const SearchScreenComponent()
              : AppViews.getSetData(
                  context,
                  value.mShowData,
                  RefreshIndicator(
                    onRefresh: value.getStores,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.stores.length,
                            itemBuilder: (context, index) {
                              return ShopItemComponent(
                                storeModel: value.stores[index],
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   'Populer Accessories',
                        //   style: regularText(18),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 30),
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
                        //   maxLines: 1,
                        //   style: regularText(18),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 30),
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
                      ],
                    ),
                  ));
        });
  }
}
