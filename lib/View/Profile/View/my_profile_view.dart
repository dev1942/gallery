import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Profile/Model/otp_phoneno_model.dart';
import 'package:otobucks/View/Profile/View/widget/my_car_list_widget.dart';
import 'package:otobucks/View/Profile/Controller/profile_screen_controller.dart';
import 'package:otobucks/controllers/auth_controllers/otp_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/page/auth/otp_screen.dart';
import 'package:otobucks/services/repository/otp_repo.dart';
import 'package:otobucks/widgets/category_item.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_textfield_mobile.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/image_view.dart';
import 'package:otobucks/widgets/small_button.dart';
import 'package:otobucks/widgets/wallet/withdraw_money_dialog.dart';


import '../Model/car_list_model.dart';

class MyProfileFragment extends StatefulWidget {
  const MyProfileFragment({Key? key}) : super(key: key);

  @override
  MyProfileFragmentState createState() => MyProfileFragmentState();
}

class MyProfileFragmentState extends State<MyProfileFragment> {
  var controller = Get.put(ProfileScreenController());
  var Otpcontroller = Get.put(OtpController());
  bool IsAddCarTap=false;
  bool isEditidTab=false;
  String? editId;

  @override
  void initState() {
  controller.getCarList();
  controller.getProfile();
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double marginBoth = AppDimens.dimens_20;
    double height = AppDimens.dimens_36;
    double imgHeight = AppDimens.dimens_90;
    double iconSize = AppDimens.dimens_18;

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
                  height: 0,
                ),
                GetBuilder<ProfileScreenController>(
                    init: ProfileScreenController(),
                    builder: (value) => AppViews.getSetData(
                        context,
                        value.mShowData,
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              // Text(  value.isPhoneVerified.toString()),
                              // profile pic and name
                              Stack(
                                children: [
                                  Container(
                                    color: AppColors.colorBlueStart,
                                    height: AppDimens.dimens_110,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: AppDimens.dimens_40,
                                        bottom: AppDimens.dimens_30),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Global.checkNull(value.imgProfilePic)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimens.dimens_5),
                                                child: Global.isURL(
                                                        value.imgProfilePic)
                                                    ? NetworkImageCustom(
                                                        image:
                                                            value.imgProfilePic,
                                                        fit: BoxFit.fill,
                                                        height: AppDimens
                                                            .dimens_130,
                                                        width: AppDimens
                                                            .dimens_130)
                                                    : ImageView(
                                                        strImage:
                                                            value.imgProfilePic,
                                                        height: AppDimens
                                                            .dimens_130,
                                                        width: AppDimens
                                                            .dimens_130),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimens.dimens_5),
                                                child: Container(
                                                  height: AppDimens.dimens_130,
                                                  width: AppDimens.dimens_130,
                                                  padding: const EdgeInsets.all(
                                                      AppDimens.dimens_16),
                                                  child: Image.asset(
                                                    AppImages.ic_user_sufix,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: InkWell(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  bottomRight: Radius.circular(
                                                      AppDimens.dimens_5)),
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                    AppDimens.dimens_5),
                                                color: AppColors.colorWhite,
                                                child: Image.asset(
                                                    AppImages
                                                        .ic_edit_profile_icon,
                                                    width: AppDimens.dimens_20,
                                                    height:
                                                        AppDimens.dimens_20),
                                              ),
                                            ),
                                            onTap: () {
                                              value.selectProfilePic(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // AppViews.showLoadingWithStatus(isShowLoader)
                                ],
                              ),

                              // user name & Location
                              Card(
                                elevation: AppDimens.dimens_8,
                                margin: const EdgeInsets.only(
                                    left: AppDimens.dimens_90,
                                    right: AppDimens.dimens_90),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: AppDimens.dimens_15),
                                            alignment: Alignment.center,
                                            child: Text(
                                              value.strFname +
                                                  " " +
                                                  value.strLname,
                                              style:
                                                  AppStyle.textViewStyleLarge(
                                                      context: context,
                                                      color:
                                                          AppColors.colorBlack,
                                                      fontSizeDelta: 3,
                                                      fontWeightDelta: 0),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(
                                                bottom: AppDimens.dimens_15,
                                                top: AppDimens.dimens_2),
                                            child: Text(
                                              value.strCountry,
                                              style:
                                                  AppStyle.textViewStyleSmall(
                                                      context: context,
                                                      color:
                                                          AppColors.colorGray4,
                                                      fontSizeDelta: -2),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: AppDimens.dimens_8,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: height,
                                        width: height,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.location_on,
                                          size: iconSize,
                                        ),
                                        // padding: EdgeInsets.all(AppDimens.dimens_10),
                                      ),
                                    ),
                                    Flexible(
                                        child: CustomTextFieldWithIcon(
                                      height: height,
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      focusNode: value.mFocusNodeAddress,
                                      controller: value.controllerAddress,
                                      keyboardType: TextInputType.text,
                                      hintText: Constants.STR_ADDRESS,
                                      inputFormatters: const [],
                                      obscureText: false,
                                      onChanged: (String value) {},
                                      suffixIcon: InkWell(
                                        child: Image.asset(
                                            AppImages.ic_edit_profile_icon,
                                            color: AppColors.colorBlack,
                                            width: iconSize,
                                            height: iconSize),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: AppDimens.dimens_8,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: height,
                                        width: height,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.call,
                                          size: iconSize,
                                        ),
                                        // padding: EdgeInsets.all(AppDimens.dimens_10),
                                      ),
                                    ),
                                    Expanded(
                                        child: CustomTextFieldMobile(
                                      strCountyCode: value.strCountyCode,
                                      textInputAction: TextInputAction.done,
                                    readonly: true,
                                          // enabled: false,
                                    //  enabled: true,
                                      height: height,
                                      controller: value.controllerPhone,
                                      focusNode: value.mFocusNodePhone,
                                          suffixIcon: InkWell(
                                            onTap: (){
                                              showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                title: const Text('Edit Number'),
                                                content:  TextField(
                                                  controller: value.controllerPhone,
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                              Navigator.pop(context, 'OK');
                                              },
                                                    child: const Text('Submit'),
                                                  ),
                                                ],
                                              ));
                                            },
                                            child: Image.asset(
                                                AppImages.ic_edit_profile_icon,
                                                color: AppColors.colorBlack,
                                                width: iconSize,
                                                height: iconSize),
                                          ),
                                    )),
                                    value.isPhoneVerified && value.oldPhoneNumebr==value.controllerPhone.text ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5,left: 5.0),
                                      child: Image.asset(
                                        'assets/images/ic_verified.png',
                                        height: 20,
                                      ),
                                    )
                                        : SizedBox(
                                            height: 30,
                                            width: 50,
                                            child: PrimaryButton(
                                              color: null,
                                              label: const Text('verify'),
                                              onPress: () {
                                                gotoMobileOTPScreen(context,value.controllerPhone.text);
                                              },
                                            ),
                                          )

                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: AppDimens.dimens_8,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: height,
                                        width: height,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.email,
                                          size: iconSize,
                                        ),
                                        // padding: EdgeInsets.all(AppDimens.dimens_10),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child:
                                            Text(value.controllerEmail.text)),
                                    if (value.isEmailVerified)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Image.asset(
                                          'assets/images/ic_verified.png',
                                          height: 20,
                                        ),
                                      )
                                    // child: Icon(Icons),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: marginBoth + AppDimens.dimens_10,
                                      left: marginBoth + 5),
                                  child: Text(
                                    Constants.STR_EMERGENCY_CONTACT_DETAIL,
                                    style: AppStyle.textViewStyleLarge(
                                        context: context,
                                        color: AppColors.colorBlack,
                                        fontSizeDelta: 3,
                                        fontWeightDelta: 0),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: AppDimens.dimens_8,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: height,
                                        width: height,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.location_on,
                                          size: iconSize,
                                        ),
                                        // padding: EdgeInsets.all(AppDimens.dimens_10),
                                      ),
                                    ),
                                    Flexible(
                                        child: CustomTextFieldWithIcon(
                                      height: height,
                                      textInputAction: TextInputAction.next,
                                      enabled: value.isEnableEmgName,
                                      focusNode: value.mFocusNodeEmgName,
                                      controller: value.controllerEmgName,
                                      keyboardType: TextInputType.text,
                                      hintText: Constants.STR_NAME,
                                      inputFormatters: const [],
                                      obscureText: false,
                                      onChanged: (String value) {},
                                      suffixIcon: InkWell(
                                        child: Image.asset(
                                            AppImages.ic_edit_profile_icon,
                                            color: AppColors.colorBlack,
                                            width: iconSize,
                                            height: iconSize),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: AppDimens.dimens_8,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: height,
                                        width: height,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.call,
                                          size: iconSize,
                                        ),
                                        // padding: EdgeInsets.all(AppDimens.dimens_10),
                                      ),
                                    ),
                                    Flexible(
                                        child: CustomTextFieldMobile(
                                      strCountyCode: value.strEmgCountyECode,
                                      textInputAction: TextInputAction.done,
                                      enabled: value.isEnableEmgPhone,
                                      height: height,
                                      controller: value.controllerEmgPhone,
                                      focusNode: value.mFocusNodeEmgPhone,
                                      suffixIcon: InkWell(
                                        child: Image.asset(
                                            AppImages.ic_edit_profile_icon,
                                            color: AppColors.colorBlack,
                                            width: iconSize,
                                            height: iconSize),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              /*--------------------------Add Car Button--------------------------------------*/
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: marginBoth),
                                    child: CustomButton(
                                        isGradient: true,
                                        isRoundBorder: true,
                                        height: height,
                                        fontSize: -2,
                                        fontColor: AppColors.colorWhite,
                                        width: size.width / 1.8,
                                        onPressed: () {},
                                        strTitle:
                                            Constants.STR_ENTER_YOUR_CAR_DETAILS),
                                  ),
                                  SizedBox(width: 10.0),
                                  //profile-------
                                  Container(
                                    margin: EdgeInsets.only(top: marginBoth),
                                    child: CustomButton(
                                        isGradient: true,
                                        isRoundBorder: true,
                                        height: height,
                                        fontSize: -2,
                                        fontColor: AppColors.colorWhite,
                                        width: size.width / 3.2,
                                        onPressed: () {
                                         setState(() {
                                           IsAddCarTap=true;
                                           //IsAddCarTap =! IsAddCarTap;
                                         });
                                        },
                                        strTitle:
                                        "Add Car"//Constants.STR_ENTER_YOUR_CAR_DETAILS
                                    ),
                                  ),
                                ],
                              ),

                              /*---------------------------------Add Car Inputs File Start---------------------------------------------*/
                         IsAddCarTap || isEditidTab ? Column(children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: marginBoth,
                                      left: marginBoth),
                                  decoration: AppViews.getRoundBorder(
                                      cBoxBgColor: AppColors.colorWhite,
                                      cBorderColor: AppColors.colorBorder2,
                                      dRadius: AppDimens.dimens_5,
                                      dBorderWidth: AppDimens.dimens_1),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5),
                                      child: CustomTextFieldWithIcon(
                                        height: height,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerCarBrand,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_BRAND,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_car,
                                            width: iconSize, height: iconSize),
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: marginBoth,
                                      left: marginBoth),
                                  decoration: AppViews.getRoundBorder(
                                      cBoxBgColor: AppColors.colorWhite,
                                      cBorderColor: AppColors.colorBorder2,
                                      dRadius: AppDimens.dimens_5,
                                      dBorderWidth: AppDimens.dimens_1),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5),
                                      child: CustomTextFieldWithIcon(
                                        height: height,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerCarModelYear,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_MODEL_YEAR,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_car,
                                            width: iconSize, height: iconSize),
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: marginBoth,
                                      left: marginBoth),
                                  decoration: AppViews.getRoundBorder(
                                      cBoxBgColor: AppColors.colorWhite,
                                      cBorderColor: AppColors.colorBorder2,
                                      dRadius: AppDimens.dimens_5,
                                      dBorderWidth: AppDimens.dimens_1),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5),
                                      child: CustomTextFieldWithIcon(
                                        height: height,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerMileage,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_MILEAGE,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(
                                            AppImages.ic_petrol,
                                            width: iconSize,
                                            height: iconSize),
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: marginBoth,
                                      left: marginBoth),
                                  decoration: AppViews.getRoundBorder(
                                      cBoxBgColor: AppColors.colorWhite,
                                      cBorderColor: AppColors.colorBorder2,
                                      dRadius: AppDimens.dimens_5,
                                      dBorderWidth: AppDimens.dimens_1),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5),
                                      child: CustomTextFieldWithIcon(
                                        height: height,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerColour,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_COLOUR,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(
                                            AppImages.ic_color,
                                            width: iconSize,
                                            height: iconSize),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: marginBoth),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Car Plate Number',
                                      style: regularText600(15),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: marginBoth,
                                      top: 10,
                                      left: marginBoth),
                                  decoration: AppViews.getRoundBorder(
                                      cBoxBgColor: AppColors.colorWhite,
                                      cBorderColor: AppColors.colorBorder2,
                                      dRadius: AppDimens.dimens_5,
                                      dBorderWidth: AppDimens.dimens_1),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: height,
                                              textInputAction:
                                              TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerCode,
                                              keyboardType: TextInputType.text,
                                              hintText: 'Code',
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 1.5,
                                            color: AppColors.lightGrey,
                                            margin:
                                            const EdgeInsets.only(bottom: 4),
                                          ),
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: height,
                                              textInputAction:
                                              TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerCity,
                                              keyboardType: TextInputType.text,
                                              hintText: 'City',
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 1.5,
                                            color: AppColors.lightGrey,
                                            margin:
                                            const EdgeInsets.only(bottom: 4),
                                          ),
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: height,
                                              textInputAction:
                                              TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerNumber,
                                              keyboardType: TextInputType.text,
                                              hintText: 'Number',
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Visibility(
                                  visible: isEditidTab,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Container(
                                      margin: EdgeInsets.only(top: marginBoth),
                                      child: CustomButton(
                                          isGradient: true,
                                          isRoundBorder: true,
                                          height: height,
                                          fontSize: -2,
                                          fontColor: AppColors.colorWhite,
                                          width: size.width / 2.2,
                                          onPressed: () {
                                         controller.clearController();
                                            setState(() {
                                              isEditidTab=false;
                                            });
                                          },
                                          strTitle: "Cancel"
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      margin: EdgeInsets.only(top: marginBoth),
                                      child: CustomButton(
                                          isGradient: true,
                                          isRoundBorder: true,
                                          height: height,
                                          fontSize: -2,
                                          fontColor: AppColors.colorWhite,
                                          width: size.width / 2.2,
                                          onPressed: () {
                                            if(
                                            value.controllerCarBrand.text.isNotEmpty&&
                                                value.controllerColour.text.isNotEmpty&&
                                                value.controllerCarModelYear.text.isNotEmpty&&
                                                value.controllerMileage.text.isNotEmpty&&
                                                value.controllerCity.text.isNotEmpty&&
                                                value.controllerCode.text.isNotEmpty&&
                                                value.controllerNumber.text.isNotEmpty){
                                              controller.UpdateCar(value.controllerCarBrand.text,
                                                  value.controllerColour.text,
                                                  value.controllerCarModelYear.text,
                                                  value.controllerMileage.text,
                                                  value.controllerCity.text,
                                                  value.controllerCode.text,
                                                  value.controllerNumber.text,editId??"");
                                              setState(() {
                                                isEditidTab=false;
                                                IsAddCarTap=false;
                                              });
                                            }else{
                                              Global.showToastAlert(
                                                  context: Get.overlayContext!,
                                                  strTitle: "",
                                                  strMsg: "Please Fill All Fields",
                                                  toastType: TOAST_TYPE.toastError);
                                            }
                                          },
                                          strTitle:
                                         "Update"

                                      ),
                                    ),
                                  ],),
                                ),
                                Visibility(
                                  visible: !isEditidTab,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: marginBoth),
                                        child: CustomButton(
                                            isGradient: true,
                                            isRoundBorder: true,
                                            height: height,
                                            fontSize: -2,
                                            fontColor: AppColors.colorWhite,
                                            width: size.width / 2.2,
                                            onPressed: () {
                                              controller.clearController();
                                              setState(() {
                                                IsAddCarTap=false;
                                              });
                                            },
                                            strTitle: "Cancel"
                                        ),
                                      ),
                                     const SizedBox(width: 10.0),
                                      Container(
                                        margin: EdgeInsets.only(top: marginBoth),
                                        child: CustomButton(
                                            isGradient: true,
                                            isRoundBorder: true,
                                            height: height,
                                            fontSize: -2,
                                            fontColor: AppColors.colorWhite,
                                            width: size.width / 2.2,
                                            onPressed: () {
                                              if(
                                              value.controllerCarBrand.text.isNotEmpty&&
                                              value.controllerColour.text.isNotEmpty&&
                                              value.controllerCarModelYear.text.isNotEmpty&&
                                              value.controllerMileage.text.isNotEmpty&&
                                              value.controllerCity.text.isNotEmpty&&
                                              value.controllerCode.text.isNotEmpty&&
                                              value.controllerNumber.text.isNotEmpty){
                                                controller.addNewCar(
                                                    value.controllerCarBrand.text,
                                                    value.controllerColour.text,
                                                    value.controllerCarModelYear.text,
                                                    value.controllerMileage.text,
                                                    value.controllerCity.text,
                                                    value.controllerCode.text,
                                                    value.controllerNumber.text);
                                                setState(() {
                                                  IsAddCarTap=false;
                                                });
                                              }else{
                                                Global.showToastAlert(
                                                    context: Get.overlayContext!,
                                                    strTitle: "",
                                                    strMsg: "Please Fill All Fields",
                                                    toastType: TOAST_TYPE.toastError);
                                              }


                                            },
                                            strTitle:
                                             Constants.SAVE

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],):SizedBox(),

                              /*---------------------------------Add Car Inputs File Start End---------------------------------------------*/


                              /*---------------------------------Car List----------------------------------------------*/
                             SizedBox(height: 10.0),

                              controller.carList.isNotEmpty?ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                              itemCount: controller.carList.length,
                          itemBuilder: (BuildContext contextM, index) {
                            GetCarModelResult? mcarlistmodel = controller.carList[index];
                            return MyCarListItem(
                                carBrand:mcarlistmodel.brand??"",
                                modeYear:mcarlistmodel.modelYear??"",
                                km:mcarlistmodel.mileage??"",
                                color:mcarlistmodel.color??"",
                                code:mcarlistmodel.carCode??"",
                                city:mcarlistmodel.carCity??"",
                                number: mcarlistmodel.carNumber??"",
                                image:"https://s3.amazonaws.com/cdn.carbucks.com/520e5860-fab9-4d18-904f-919e7cd7667e.png",
                                onEditTap: () {
                                  value.controllerCarBrand.text=mcarlistmodel.brand??"";
                                  value.controllerColour.text=mcarlistmodel.color??"";
                                  value.controllerCarModelYear.text=mcarlistmodel.modelYear??"";
                                  value.controllerMileage.text=mcarlistmodel.mileage??"";
                                  value.controllerCity.text=mcarlistmodel.carCity??"";
                                  value.controllerCode.text=mcarlistmodel.carCode??"";
                                  value.controllerNumber.text=mcarlistmodel.carNumber??"";
                                  setState(() {
                                    isEditidTab=true;
                                    editId=mcarlistmodel.Id??"0";
                                  });
                                  // controller.onTapCategory(mCategoryModel);
                            },
                                onDeleteTap: () {
                                    controller.deletecar(mcarlistmodel.Id??"0");
                                 // });


                          });

                          }):SizedBox(),


                              /*---------------------------------Car List End------------------------------------------*/

                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth + AppDimens.dimens_40,
                                    left: marginBoth),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !Global.checkNull(value.imgMulkia)
                                        ? Card(
                                            elevation: AppDimens.dimens_4,
                                            shadowColor: AppColors.shadowColor
                                                .withOpacity(0.6),
                                            child: InkWell(
                                              child: Container(
                                                width: size.width / 3,
                                                alignment: Alignment.center,
                                                height: imgHeight,
                                                padding: const EdgeInsets.all(
                                                    AppDimens.dimens_5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .add_circle_outline_sharp),
                                                    Container(
                                                      child: Text(
                                                        Constants
                                                            .STR_ADD_MULKIA,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .textViewStyleSmall(
                                                                context:
                                                                    context,
                                                                color: AppColors
                                                                    .colorBlack),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: AppDimens
                                                                  .dimens_4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                value.selectDocs(
                                                    IdType.mulkia, context);
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: size.width / 3,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 3,
                                                  child: Global.isURL(
                                                          value.imgMulkia)
                                                      ? NetworkImageCustom(
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                          image:
                                                              value.imgMulkia)
                                                      : ImageView(
                                                          strImage:
                                                              value.imgMulkia,
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(
                                                              Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(
                                                                  mColor: AppColors
                                                                      .colorWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  mBorderRadius:
                                                                      5),
                                                        ),
                                                        onTap: () =>
                                                            value.removeImage(
                                                                'mulkia')))
                                              ],
                                            ),
                                          ),
                                    const SizedBox(width: AppDimens.dimens_18),
                                    !Global.checkNull(value.imgDrivingLicence)
                                        ? Card(
                                            elevation: AppDimens.dimens_4,
                                            shadowColor: AppColors.shadowColor
                                                .withOpacity(0.6),
                                            child: InkWell(
                                              child: Container(
                                                width: size.width / 3,
                                                alignment: Alignment.center,
                                                height: imgHeight,
                                                padding: const EdgeInsets.all(
                                                    AppDimens.dimens_5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .add_circle_outline_sharp),
                                                    Container(
                                                      child: Text(
                                                        Constants
                                                            .STR_ADD_DRIVING_LICENCE,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .textViewStyleSmall(
                                                                context:
                                                                    context,
                                                                color: AppColors
                                                                    .colorBlack),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: AppDimens
                                                                  .dimens_4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                value.selectDocs(
                                                    IdType.drivingLicence,
                                                    context);
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: size.width / 3,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 3,
                                                  child: Global.isURL(value
                                                          .imgDrivingLicence)
                                                      ? NetworkImageCustom(
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                          image: value
                                                              .imgDrivingLicence)
                                                      : ImageView(
                                                          strImage: value
                                                              .imgDrivingLicence,
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(
                                                              Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(
                                                                  mColor: AppColors
                                                                      .colorWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  mBorderRadius:
                                                                      5),
                                                        ),
                                                        onTap: () =>
                                                            value.removeImage(
                                                                'driving')))
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    right: marginBoth,
                                    top: marginBoth,
                                    left: marginBoth),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    !Global.checkNull(value.imgEmIdFront)
                                        ? Card(
                                            elevation: AppDimens.dimens_4,
                                            shadowColor: AppColors.shadowColor
                                                .withOpacity(0.6),
                                            child: InkWell(
                                              child: Container(
                                                width: size.width / 3,
                                                height: imgHeight,
                                                padding: const EdgeInsets.all(
                                                    AppDimens.dimens_5),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .add_circle_outline_sharp),
                                                    Container(
                                                      child: Text(
                                                        Constants
                                                            .STR_ADD_EMIRATES_ID_FRONT,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppStyle
                                                            .textViewStyleSmall(
                                                                context:
                                                                    context,
                                                                color: AppColors
                                                                    .colorBlack),
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: AppDimens
                                                                  .dimens_4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                value.selectDocs(
                                                    IdType.emIdFront, context);
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: size.width / 3,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 3,
                                                  child: Global.isURL(
                                                          value.imgEmIdFront)
                                                      ? NetworkImageCustom(
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                          image: value
                                                              .imgEmIdFront)
                                                      : ImageView(
                                                          strImage: value
                                                              .imgEmIdFront,
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(
                                                              Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(
                                                                  mColor: AppColors
                                                                      .colorWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  mBorderRadius:
                                                                      5),
                                                        ),
                                                        onTap: () =>
                                                            value.removeImage(
                                                                'emirate_front')))
                                              ],
                                            ),
                                          ),
                                    const SizedBox(width: AppDimens.dimens_18),
                                    !Global.checkNull(value.imgEmIdBack)
                                        ? Card(
                                            elevation: AppDimens.dimens_4,
                                            shadowColor: AppColors.shadowColor
                                                .withOpacity(0.6),
                                            child: InkWell(
                                              child: Container(
                                                width: size.width / 3,
                                                height: imgHeight,
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.all(
                                                    AppDimens.dimens_5),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons
                                                          .add_circle_outline_sharp),
                                                      Container(
                                                        child: Text(
                                                          Constants
                                                              .STR_ADD_EMIRATES_ID_BACK,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                                  context:
                                                                      context,
                                                                  color: AppColors
                                                                      .colorBlack),
                                                        ),
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: AppDimens
                                                                .dimens_4),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                value.selectDocs(
                                                    IdType.emIdBack, context);
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: size.width / 3,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 3,
                                                  child: Global.isURL(
                                                          value.imgEmIdBack)
                                                      ? NetworkImageCustom(
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                          image:
                                                              value.imgEmIdBack)
                                                      : ImageView(
                                                          strImage:
                                                              value.imgEmIdBack,
                                                          height: imgHeight,
                                                          width: size.width / 3,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(
                                                              Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(
                                                                  mColor: AppColors
                                                                      .colorWhite
                                                                      .withOpacity(
                                                                          0.8),
                                                                  mBorderRadius:
                                                                      5),
                                                        ),
                                                        onTap: () =>
                                                            value.removeImage(
                                                                'emirate_back')))
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(
                                    top: marginBoth, bottom: marginBoth),
                                child: CustomButton(
                                    isGradient: true,
                                    isRoundBorder: true,
                                    height: height + AppDimens.dimens_4,
                                    fontSize: 0,
                                    fontColor: AppColors.colorWhite,
                                    width: size.width / 1.5,
                                    onPressed: () {
                                      if (value.isValid(context)) {
                                        value.updateProfile(context);
                                      }
                                    },
                                    strTitle:
                                        Constants.STR_UPDATE_YOUR_PROFILE),
                              ),
                            ],
                          ),
                        ))),
                GetBuilder<ProfileScreenController>(
                    builder: (value) =>
                        AppViews.showLoadingWithStatus(value.isShowLoader))
              ],
            )));
  }
  void gotoMobileOTPScreen(BuildContext context,String phoneNumber) async {
    // ModelPhoneOTP mModelOTP = ModelPhoneOTP(
    //     phoneNumber: controllerPassword.text.toString(),
    //     otp: controllerEmail.text.toString());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPScreen(phoneNumber: phoneNumber)));
   // sendOTPTask();
    Otpcontroller.sendNumberOTPTask(phoneNumber!,context);
    //sentOTPToNumber();
  }


  Future<void> _displayVerify() async {
    return showDialog(
        context: context,
        builder: (context) {
          return WithdrawMoneyDialogBox(
            title: 'Verify Phone',
            onTap: () {},
          );
        });
  }

  // _displayAddCard() async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AddEditCardDialogBox(
  //           onTap: (CardModel mCardModelInserted) {
  //             controller.addNewCard(
  //                 mCardModelInserted.last4,
  //                 mCardModelInserted.expMonth,
  //                 mCardModelInserted.expYear,
  //                 mCardModelInserted.cvcCheck,
  //                 mCardModelInserted.name);
  //           },
  //         );
  //       });
  // }


}
