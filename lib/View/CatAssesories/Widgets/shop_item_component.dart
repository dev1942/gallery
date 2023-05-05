import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/View/CatAssesories/Models/store_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/small_button.dart';
import '../Views/explore_accessories_screem.dart';

class ShopItemComponent extends StatelessWidget {
  final AccessoriesStoreModel storeModel;
  const ShopItemComponent({Key? key, required this.storeModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      decoration: ContainerProperties.shadowDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: NetworkImageCustom(
                      height: 90,
                      width: 90,
                      image: storeModel.images!.isNotEmpty ? storeModel.images![0]??'' : '',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(storeModel.name.toString().capitalize!, maxLines: 1, style: subHeadingText(16)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        storeModel.description.toString(),
                        maxLines: 2,
                        style: lightText(12.5),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if(storeModel!.products!.isNotEmpty)
            Container(
            alignment: Alignment.center,
            height: 45,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: storeModel.products!.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.colorGray6)),
                            margin: const EdgeInsets.all(4),
                            height: 50,
                            width: 50,
                            child: Image.network(storeModel.products![index].image![0]),
                            // child: Image.asset('assets/images/ic_petrol.png'),
                          );
                        })),
                SizedBox(
                  width: 100,
                  height: 37,
                  child: PrimaryButton(
                    label: const Text(
                      'Explore Now',
                      style: TextStyle(fontSize: 13),
                    ),
                    onPress: () {
                      Get.to(() => ExploreAccessoriesScreen(
                            storeId: storeModel.sId!,
                            storeTitle: storeModel.name!,
                          ));
                    },
                    color: null,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
