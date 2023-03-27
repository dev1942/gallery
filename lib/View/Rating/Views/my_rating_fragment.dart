import 'package:flutter/material.dart';
import 'package:otobucks/app/locator.dart';
import 'package:otobucks/View/Rating/Views/Received/recived_rating_tab.dart';
import 'package:otobucks/global/Models/main_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../../global/enum.dart';
import 'Given/given_rating_tab.dart';

class MyRatingFragment extends StatefulWidget {
  const MyRatingFragment({Key? key}) : super(key: key);

  @override
  MyRatingFragmentState createState() => MyRatingFragmentState();
}

class MyRatingFragmentState extends State<MyRatingFragment> with SingleTickerProviderStateMixin {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;

  int indexM = 0;
  int activeTabIndex = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    controller.addListener(() {
      setState(() {
        activeTabIndex = controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = const TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
    double height = AppDimens.dimens_38;
    double width = size.width / 5;

    Widget mShowWidget = Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppColors.colorBlueStart,
              height: AppDimens.dimens_85,
            ),
            Container(
              margin: const EdgeInsets.only(top: AppDimens.dimens_10, left: AppDimens.dimens_3),
              child: TabBar(
                labelStyle: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack),
                indicatorColor: AppColors.colorBlueEnd,
                isScrollable: true,
                indicatorPadding: const EdgeInsets.only(left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.only(left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                labelColor: AppColors.colorWhite,
                unselectedLabelColor: AppColors.colorBlack2,
                indicator: AppViews.getRoundBorderDecor(mColor: Colors.white, mBorderRadius: 5),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    decoration: activeTabIndex != 0 ? AppViews.getColorDecor(mColor: Colors.white, mBorderRadius: 5) : null,
                    alignment: Alignment.center,
                    width: width,
                    height: height,
                    child: Text(
                      "Given",
                      style: style,
                    ),
                  ),
                  Container(
                    decoration: activeTabIndex != 1 ? AppViews.getColorDecor(mColor: Colors.white, mBorderRadius: 5) : null,
                    alignment: Alignment.center,
                    width: width,
                    height: height,
                    child: Text(
                      "Received",
                      style: style,
                    ),
                  ),
                ],
                controller: controller,
              ),
            ),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[GivenRatingTab(), RecievedRatingTab()],
          ),
        ),
        // Expanded(child: Container()),
      ],
    );

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(resizeToAvoidBottomInset: true, backgroundColor: AppColors.getMainBgColor(), body: mShowWidget));
      },
    );
  }
}
