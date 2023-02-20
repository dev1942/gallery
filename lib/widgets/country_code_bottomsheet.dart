import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_views.dart';

import '../global/app_style.dart';
import '../global/constants.dart';
import '../global/global.dart';
import '../View/Auth/Models/country_code.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  final Function onTap;

  const CountryCodeBottomSheet({Key? key, required this.onTap}) : super(key: key);

  @override
  CountryCodeBottomSheetState createState() => CountryCodeBottomSheetState();
}

class CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  List<CountryCode> countyCodeAll = [];
  List<CountryCode> countyCodeFiltered = [];

  TextEditingController controllerSearch = TextEditingController();

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      countyCodeFiltered = countyCodeAll;
    } else {
      countyCodeFiltered = countyCodeAll.where((user) => user.name.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {});
  }

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
    getCountryCodeList(CountryCode mCountryCode) {
      return InkResponse(
          onTap: () {
            widget.onTap(mCountryCode);
            Navigator.pop(context);
          },
          highlightShape: BoxShape.rectangle,
          radius: 0.0,
          child: Container(
            height: AppDimens.dimens_38,
            padding: const EdgeInsets.only(
              left: AppDimens.dimens_4,
              top: AppDimens.dimens_4,
              bottom: AppDimens.dimens_4,
              right: AppDimens.dimens_4,
            ),
//            color: i == _selectedDrawerIndex ? AppColors.colorSemiTrans : null,
            child: Padding(
              padding: const EdgeInsets.only(left: AppDimens.dimens_14),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/flag_' + mCountryCode.code.toLowerCase() + '.png',
                    height: AppDimens.dimens_26,
                    width: AppDimens.dimens_26,
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            mCountryCode.name + " (${mCountryCode.code})",
                            softWrap: true,
                            style: AppStyle.textViewStyleNormalBodyText2(
                                color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
                          )))
                ],
              ),
            ),
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: AppDimens.dimens_14),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      style:
                          AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
                      controller: controllerSearch,
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppColors.colorWhite,
                          hintStyle: AppStyle.textViewStyleNormalBodyText2(
                              color: AppColors.colorTextFieldHint, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
                          hintText: Constants.TXT_SEARCH),
                    ),
                  ),
                ),
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
              child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: countyCodeFiltered.length,
            itemBuilder: (BuildContext context, int index) {
              CountryCode mCountryCode = countyCodeFiltered[index];

              return getCountryCodeList(mCountryCode);
            },
          ))
        ],
      ),
    );
  }
}
