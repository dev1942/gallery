import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:otobucks/app/locator.dart';
import 'package:otobucks/viewmodels/main_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../services/repository/services_repo.dart';
import '../widgets/image_selection_bottom_sheet.dart';

class TermsConditionFragment extends StatefulWidget {
  const TermsConditionFragment({Key? key}) : super(key: key);

  @override
  TermsConditionFragmentState createState() => TermsConditionFragmentState();
}

class TermsConditionFragmentState extends State<TermsConditionFragment> {
  ShowData mShowData = ShowData.showData;

  bool connectionStatus = false;
  bool isShowLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    Widget mShowWidget = ListView.builder(
        padding: const EdgeInsets.all(AppDimens.dimens_20),
        itemBuilder: (BuildContext contextM, index) {
          // EstimatesModel mEstimatesModel = alEstimates[index];
          return Container(
            margin: const EdgeInsets.only(
                bottom: AppDimens.dimens_14,
                right: AppDimens.dimens_14,
                left: AppDimens.dimens_14),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        top: AppDimens.dimens_5, bottom: AppDimens.dimens_5),
                    child: Text(
                      "For Permanent License Holders",
                      style: AppStyle.textViewStyleNormalBodyText2(
                          context: context,
                          color: AppColors.colorBlack,
                          fontSizeDelta: 0,
                          fontWeightDelta: -1),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: AppDimens.dimens_5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.grayDashboardText,
                          fontSizeDelta: -2,
                          fontWeightDelta: 0),
                    )),
              ],
            ),
          );
        },
        itemCount: 4);
    widgetM = AppViews.getSetData(context, mShowData, mShowWidget);

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
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: AppColors.getMainBgColor(),
                body: Stack(
                  children: [
                    Container(
                      color: AppColors.colorBlueStart,
                      //height: AppDimens.dimens_120,
                      height: 0,
                    ),
                    // Container(height: size.height, child: widgetM),
                    widgetM,
                    AppViews.showLoadingWithStatus(isShowLoader)
                  ],
                )));
      },
    );
  }

  selectProfilePic() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImageSelection(
            isCropImage: true,
            mImagePath: (String strPath) {},
            mMaxHeight: 1024,
            mMaxWidth: 1024,
            mRatioX: 1.0,
            mRatioY: 1.0,
          );
        });
  }

  getServiceProvider() async {
    setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    });

    HashMap<String, Object> requestParams = HashMap();

    var categories =
        await ServicesRepo().getServiceDetails(requestParams, serviceId: "");

    categories.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      setState(() {
        // alServices = mResult.DATA as List<ServiceModel>;

        mShowData = ShowData.showData;
      });
    });
  }
}
