import 'package:flutter/material.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/View/CatAssesories/Models/product_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/small_button.dart';

class CartItemComponent extends StatelessWidget {
  final StoreProductModel productModel;
  const CartItemComponent({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 5),
      width: 170,
      decoration: ContainerProperties.shadowDecoration(),
      child: Column(
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 65,
                  width: 65,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: NetworkImageCustom(
                        height: 65,
                        width: 65,
                        image: productModel.subcategory!.image,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$50', maxLines: 1, style: subHeadingText(16)),
                      Text(
                        productModel.title,
                        maxLines: 2,
                        style: headingText(13),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            productModel.description.toString(),
            maxLines: 3,
            style: lightText(13),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
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
    );
  }
}
