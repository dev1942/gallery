// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Dashboard/Controllers/services_sub_cat_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import '../../../global/app_views.dart';
import '../../Dashboard/Models/category_model.dart';
import '../../../widgets/fade_in_image.dart';
import '../../Dashboard/Controllers/dashboard_controller.dart';

class AutoRepairSubCatScreen extends StatefulWidget {
  CategoryModel mCategoryModel;
  AutoRepairSubCatScreen({Key? key, required this.mCategoryModel}) : super(key: key);
  @override
  AutoRepairSubCatScreenState createState() => AutoRepairSubCatScreenState();
}

class AutoRepairSubCatScreenState extends State<AutoRepairSubCatScreen> {
  var controller = Get.put(ServicesSubCatScreenController());

  @override
  void initState() {
    super.initState();
    if (controller.alSubCategoryFiltered.isEmpty) {
      controller.getSubCategory(widget.mCategoryModel.id);
    }

    Get.find<DashboardController>().controllerSearch.addListener(() {
      controller.runFilter(Get.find<DashboardController>().controllerSearch.text.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.width / 3) + AppDimens.dimens_40;
    final double itemWidth = size.width / 3;

    Widget mShowWidget(value) => LayoutBuilder(builder: (context, size) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: ((itemWidth / itemHeight) * 0.95),
            crossAxisSpacing: size.maxWidth / 50,
            crossAxisCount: size.maxWidth > 600
                ? 5
                : size.maxWidth > 400
                    ? 4
                    : 3,
            children: List<Widget>.generate(value.alSubCategoryFiltered.length, (index) {
              CategoryModel mSubCategoryModel = value.alSubCategoryFiltered[index];

              return InkWell(
                child: Card(
                  child: Container(
                    // margin: const EdgeInsets.only(
                    //   left: AppDimens.dimens_20,
                    //   right: AppDimens.dimens_20,
                    //   bottom: AppDimens.dimens_5,
                    //   top: AppDimens.dimens_5,
                    // ),
                    margin: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_5, vertical: AppDimens.dimens_5),
                    child: Column(
                      children: [
                        Container(
                          // width: 20,
                          decoration: BoxDecoration(
                              // color: Colors.grey.withOpacity(.4),
                              borderRadius: BorderRadius.circular(AppDimens.dimens_10)),
                          // height: 70,
                          child: AspectRatio(
                            aspectRatio: 1.9 - (itemWidth / itemHeight),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppDimens.dimens_10), topRight: Radius.circular(AppDimens.dimens_10)),
                              child: NetworkImageCustom(image: mSubCategoryModel.image, height: 0, width: 0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          mSubCategoryModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: AppStyle.textViewStyleXSmall(context: context, color: AppColors.colorTextBlue, fontWeightDelta: 2)
                              .copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () => Get.find<DashboardController>().onTapSubCategory(mSubCategoryModel, context),
              );
            }),
          );
        });
    return GetBuilder<ServicesSubCatScreenController>(builder: (value) => AppViews.getSetDataGridView(context, value.mShowData, mShowWidget(value)));
  }
}
