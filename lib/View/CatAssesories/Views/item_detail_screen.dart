import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../Models/product_model.dart';

class ItemDetailsScreen extends StatefulWidget {
  final StoreProductModel productModel;
  const ItemDetailsScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: "Details",
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
                          child: Image.network(widget.productModel.image[0]),
                        ),
                        Text(
                          widget.productModel.title,
                          style: regularText600(18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.productModel.description,
                          style: lightText(14),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          child: PrimaryButton(
                              label: Text(
                                widget.productModel.currency + " " + widget.productModel.retailPrice.toString(),
                                style: regularText600(17).copyWith(color: Colors.white),
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
                    widget.productModel.promotion ?? "",
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
                          Text(widget.productModel.title, style: regularText(16)),
                          Text(
                            widget.productModel.currency + " " + widget.productModel.retailPrice.toString(),
                            style: regularText600(16).copyWith(color: AppColors.colorBlueStart),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.colorGray3)),
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (counter > 1) {
                                counter--;
                              }
                            });
                          },
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: headingText(25),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.colorGray3)),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              counter++;
                            });
                          },
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
