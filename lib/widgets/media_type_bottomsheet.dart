import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';

import '../global/global.dart';
import '../View/Auth/Models/country_code.dart';

class MediaTypeBottomSheet extends StatefulWidget {
  final Function onTap;

  const MediaTypeBottomSheet({Key? key, required this.onTap}) : super(key: key);

  @override
  MediaTypeBottomSheetState createState() => MediaTypeBottomSheetState();
}

class MediaTypeBottomSheetState extends State<MediaTypeBottomSheet> {
  List<CountryCode> countyCodeAll = [];
  List<CountryCode> countyCodeFiltered = [];

  TextEditingController controllerSearch = TextEditingController();

  final List<String> howYouHear = [
    'Facebook',
    'Instagram',
    'Linkedin',
    'Twitter',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    countyCodeFiltered = Global.getCountyCode();
    countyCodeAll = Global.getCountyCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getCountryCodeList(String mCountryCode) {
      return InkResponse(
          onTap: () {
            widget.onTap(mCountryCode);
            Navigator.pop(context);
          },
          highlightShape: BoxShape.rectangle,
          radius: 0.0,
          child: Column(
            children: [
              ListTile(
                  title: Text(
                mCountryCode,
              )),
              const Divider()
            ],
          ));
    }

    return Container(
      color: AppColors.colorWhite,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(AppDimens.dimens_8),
            child: Row(
              children: [
                InkResponse(
                  child: const Icon(Icons.arrow_back),
                  onTap: () {
                    setState(() {
                      controllerSearch.clear();
                    });
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                InkResponse(
                  child: const Icon(Icons.clear),
                  onTap: () {
                    setState(() {
                      controllerSearch.clear();
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          AppViews.addDivider(),
          Expanded(
              child: ListView.builder(
            itemCount: howYouHear.length,
            itemBuilder: (BuildContext context, int index) {
              String mCountryCode = howYouHear[index];

              return getCountryCodeList(mCountryCode);
            },
          ))
        ],
      ),
    );
  }
}
