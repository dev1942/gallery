import 'package:flutter/material.dart';
import 'package:otobucks/View/CatBuyCar/Views/rent_acar_date_selection.dart';

import '../../../global/app_views.dart';
import '../../../widgets/small_button.dart';

class FilterAcarScreen extends StatefulWidget {
  const FilterAcarScreen({Key? key}) : super(key: key);

  @override
  State<FilterAcarScreen> createState() => _FilterAcarScreenState();
}

class _FilterAcarScreenState extends State<FilterAcarScreen> {
  RangeValues values = RangeValues(1, 100);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Rent a car',
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    buttonHight: 50,
                    label: const Text('New Car'),
                    color: null,
                    onPress: () {},
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      'Used Car',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Car Company',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  // margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      'BMW',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Car Model',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  // margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      'X6(G06)',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Model year',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  // margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      '2016',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Car color',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  // margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Price Range',
                style: TextStyle(color: Colors.black),
              ),
            ),
            RangeSlider(
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.grey[300],
                divisions: 5,
                min: 1,
                max: 100,
                values: values,
                onChanged: (value) {
                  setState(() {
                    values = value;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Millage Range',
                style: TextStyle(color: Colors.black),
              ),
            ),
            RangeSlider(
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.grey[300],
                divisions: 5,
                min: 1,
                max: 100,
                values: values,
                onChanged: (value) {
                  setState(() {
                    values = value;
                  });
                }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Body Type',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Material(
                  borderRadius: BorderRadius.circular(9),
                  elevation: 2,
                  child: Container(
                    // margin: EdgeInsets.only(right: 10),

                    width: size.width * 0.18,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.network(
                          "https://www.iconpacks.net/icons/1/free-car-icon-1057-thumb.png",
                          color: Colors.grey,
                        ),
                        const Text("Sedan")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Transmission Type',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    buttonHight: 50,
                    label: const Text('Automatic'),
                    color: null,
                    onPress: () {},
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      'Manual',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Fuel type',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(4),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  // margin: EdgeInsets.only(right: 10),
                  height: 60,
                  width: size.width * 0.4,
                  child: PrimaryButton(
                    label: const Text(
                      'Petrol',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.white,
                    onPress: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              // margin: EdgeInsets.only(right: 10),
              height: 60,
              width: size.width * 0.4,
              child: PrimaryButton(
                label: const Text(
                  'Apply Filters',
                  style: TextStyle(color: Colors.white),
                ),
                color: null,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RentCarDateSelectionFragment()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
