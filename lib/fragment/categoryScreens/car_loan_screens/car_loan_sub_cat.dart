import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/category_screens_controllers/auto_loans_controller.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/model/auto_loan_model.dart';
import 'package:otobucks/model/category_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../../../page/carLoans/explore_screen.dart';

class AutoLoansScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const AutoLoansScreen({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<AutoLoansScreen> createState() => _AutoLoansScreenState();
}

class _AutoLoansScreenState extends State<AutoLoansScreen> {
  var controller = Get.put(AutoLoansScreenController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Global.inProgressAlert(Get.overlayContext!);
      controller.getSubCategory(widget.categoryModel.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AutoLoansScreenController>(
        init: AutoLoansScreenController(),
        builder: (value) => AppViews.getSetDataGridView(
            context,
            value.mShowData,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.alSubCategoryFiltered.length,
                    itemBuilder: (contextt, index) {
                      AutoLoanModel autoLoanModel =
                          value.alSubCategoryFiltered[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 24),
                        width: double.infinity,
                        decoration: ContainerProperties.shadowDecoration(),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 75,
                                    width: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: NetworkImageCustom(
                                        height: 75,
                                        image: autoLoanModel.image,
                                        width: 75,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(autoLoanModel.title.toString(),
                                            maxLines: 1,
                                            style: subHeadingText(16)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          autoLoanModel.description.toString(),
                                          maxLines: 2,
                                          style: lightText(13),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    width: 100,
                                    height: 35,
                                    child: PrimaryButton(
                                      label: const Text('Explore Now'),
                                      onPress: () {
                                        Get.to(() => ExploreLoanScreen(
                                            autoLoanModel: autoLoanModel));
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
                    }),
              ],
            )));
  }
}
