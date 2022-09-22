import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/text_styles.dart';

class CartComponent extends StatelessWidget {
  const CartComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: ContainerProperties.simpleDecoration()
          .copyWith(color: AppColors.grayDashboardItem),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/images/ic_facebook.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Car Mart ',
                            maxLines: 1, style: subHeadingText(17)),
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: AppColors.colorBlueStart,
                      )
                    ],
                  ),
                  Text(
                    'This is cart marts here. This is cart marts here',
                    maxLines: 2,
                    style: lightText(12),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 30,
                              width: 40,
                              child: Icon(Icons.remove),
                            ),
                            Text(
                              '1',
                              style: headingText(15),
                            ),
                            const SizedBox(
                              height: 30,
                              width: 40,
                              child: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$50',
                        style: regularText600(15)
                            .copyWith(color: AppColors.colorBlueStart),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
