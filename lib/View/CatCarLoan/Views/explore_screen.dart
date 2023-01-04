import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatCarLoan/Views/inquiry_form_screen.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/View/CatCarLoan/Models/auto_loan_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/small_button.dart';

class ExploreLoanScreen extends StatefulWidget {
  final AutoLoanModel autoLoanModel;

  const ExploreLoanScreen({Key? key, required this.autoLoanModel})
      : super(key: key);

  @override
  State<ExploreLoanScreen> createState() => _ExploreLoanScreenState();
}

class _ExploreLoanScreenState extends State<ExploreLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.autoLoanModel.title.toString(),
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: Stack(
        children: [
          ListView(children: [
            Container(
              color: AppColors.colorBlueStart,
              width: double.infinity,
              height: AppDimens.dimens_60,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: NetworkImageCustom(
                            height: 90,
                            image: widget.autoLoanModel.image,
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.autoLoanModel.title.toString(),
                      style: regularText600(17),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Lorem Ipsum',
                      style: regularText600(15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Lorem Ipsum Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Eligibility Criteria and Documents Required',
                      style: regularText600(15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Lorem Ipsum Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Identity Proof (any of the following)',
                      style: regularText600(15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    Text(
                      '• Lorem Ipsum Effective interest rate is 7.95%',
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque gravida eu tellus vel mattis. Aliquam volutpat vehicula lacus sit amet volutpat. Nunc vitae nibh in sem venenatis auctor id sit amet tellus. Pellentesque elementum metus est, ut finibus urna auctor id. Cras  iverra dolor non commodo posuere. Cras sed leo tellus.",
                      style: lightText(12).copyWith(height: 1.7),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                )
              ],
            )
          ]),
          Positioned(
            left: 15,
            right: 15,
            bottom: 10,
            child: SizedBox(
              height: 50,
              child: PrimaryButton(
                label: const Text('Inquiry Now'),
                color: null,
                onPress: () {
                  Get.to(() => const InquiryFormScreenCarLoans());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
