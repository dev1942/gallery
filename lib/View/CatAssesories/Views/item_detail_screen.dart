import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/small_button.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Details',
        isShowNotification: false,
        isShowSOS: false,
      ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: ContainerProperties.shadowDecoration(),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                      bottom: AppDimens.dimens_14,
                      top: AppDimens.dimens_14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 170,
                          child: Image.asset('assets/images/ic_facebook.png'),
                        ),
                        Text(
                          'FaceBook',
                          style: regularText600(18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing.',
                          style: lightText(14),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          child: PrimaryButton(
                              label: Text(
                                '\$50',
                                style: regularText600(17)
                                    .copyWith(color: Colors.white),
                              ),
                              onPress: null,
                              color: null),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // height: AppDimens.dimens_190,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing. Lorem Ipsum is simply dummy text of the printing Lorem Ipsum is simply dummy text of the printing',
                    style: lightText(14),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Face book', style: regularText(16)),
                          Text(
                            '\$50',
                            style: regularText600(16)
                                .copyWith(color: AppColors.colorBlueStart),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGray3)),
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        '1',
                        style: headingText(30),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGray3)),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryButton(
                      label: Text(
                        'Add to cart',
                        style: regularText600(17).copyWith(color: Colors.white),
                      ),
                      onPress: () {},
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
