import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/small_button.dart';
import '../Controllers/accessories_sub_cat_controller.dart';

class SearchScreenComponent extends StatefulWidget {
  const SearchScreenComponent({Key? key}) : super(key: key);

  @override
  State<SearchScreenComponent> createState() => _SearchScreenComponentState();
}

class _SearchScreenComponentState extends State<SearchScreenComponent> {
  var controller = Get.put(AccessoriesSubCatController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (contextt, index) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 24),
                width: double.infinity,
                decoration: ContainerProperties.shadowDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'assets/images/ic_facebook.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('Facebook',
                                        maxLines: 1, style: subHeadingText(15)),
                                    const Spacer(),
                                    Text('\$50',
                                        maxLines: 1,
                                        style: subHeadingText(16).copyWith(
                                            color: AppColors.colorBlueStart)),
                                  ],
                                ),
                                Text(
                                  'This is cart marts here. This is cart marts here',
                                  maxLines: 2,
                                  style: lightText(13),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 10,
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
            }),
      ],
    );
  }
}
