import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/category_model.dart';
import '../../../widgets/category_item.dart';
import '../Controllers/dashboard_controller.dart';

class DashboardItemList extends StatelessWidget {
  DashboardItemList({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext contextM, index) {
          CategoryModel mCategoryModel = controller.alCategory[index];
          return CategoryItem(
              strTitle: mCategoryModel.title,
              strSubTitle: mCategoryModel.description,
              image: mCategoryModel.image,
              onTap: () {
                controller.onTapCategory(mCategoryModel);
              });
        },
        itemCount: controller.alCategory.length);
  }
}
