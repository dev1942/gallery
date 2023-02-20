import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Profile/View/widget/my_car_list_widget.dart';
import 'package:otobucks/View/Profile/Controller/profile_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_textfield_mobile.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/image_view.dart';
import 'package:otobucks/widgets/small_button.dart';
import '../../Auth/controllers/registration_controller.dart';
import '../../Auth/View/otp_screen.dart';
import '../../Auth/controllers/otp_controller.dart';
import '../Model/car_list_model.dart';

class MyProfileFragment extends StatefulWidget {
  const MyProfileFragment({Key? key}) : super(key: key);

  @override
  MyProfileFragmentState createState() => MyProfileFragmentState();
}

class MyProfileFragmentState extends State<MyProfileFragment> {
  var controller = Get.put(ProfileScreenController());
  var otpcontroller = Get.put(OtpController());
  bool isAddCarTap = false;
  bool isEditidTab = false;
  String? editId;
  @override
  void initState() {
    // if (controller.carList.isEmpty && controller.mUserModel == null) {
    controller.getCarList();
    controller.getProfile();
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Get.put(RegistrationScreenController());
    var size = MediaQuery.of(context).size;
    // double marginBoth = AppDimens.dimens_20;
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
                      RefreshIndicator(
                        onRefresh: controller.pullToRefresh,
                        child: SingleChildScrollView(
                            child: Column(children: [
                          // Text(  value.isPhoneVerified.toString()),
                          // profile pic and name
                          Stack(
                            children: [
                              Container(
                                color: AppColors.colorBlueStart,
                                height: AppDimens.dimens_80,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: AppDimens.dimens_15),
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Global.checkNull(value.imgProfilePic)
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(AppDimens.dimens_80),
                                            child: Global.isURL(value.imgProfilePic)
                                                ? NetworkImageCustom(
                                                    image: value.imgProfilePic,
                                                    fit: BoxFit.fill,
                                                    height: AppDimens.dimens_130,
                                                    width: AppDimens.dimens_130)
                                                : ImageView(strImage: value.imgProfilePic, height: AppDimens.dimens_130, width: AppDimens.dimens_130),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(AppDimens.dimens_80),
                                            child: Container(
                                              height: AppDimens.dimens_130,
                                              width: AppDimens.dimens_130,
                                              padding: const EdgeInsets.all(AppDimens.dimens_16),
                                              child: Image.asset(
                                                AppImages.ic_user_sufix,
                                                color: Colors.white,
                                              ),
                                              color: Colors.grey.withOpacity(0.7),
                                            ),
                                          ),
                                    Positioned(
                                      bottom: AppDimens.dimens_10,
                                      right: 0,
                                      child: InkWell(
                                        child: CircleAvatar(
                                          radius: 17,
                                          child: Image.asset(AppImages.ic_edit_profile_icon,
                                              width: AppDimens.dimens_15, color: AppColors.colorWhite, height: AppDimens.dimens_20),
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
                          //-----------------------------------Main Column ---------------------------//
                          //.................. user name & Location...................
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  value.strFname.toUpperCase() + " " + value.strLname.toUpperCase(),
                                  style: AppStyle.textViewStyleLarge(
                                      context: context, color: AppColors.colorBlack, fontSizeDelta: 3, fontWeightDelta: 0),
                                ),
                                Text(
                                  value.strCountry,
                                  style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorGray4, fontSizeDelta: -1),
                                ),
                                addVerticleSpace(AppDimens.dimens_10),
                                //..............................Text Field user name....................................
                                CustomTextFieldWithIcon(
                                    height: 42,
                                    textInputAction: TextInputAction.next,
                                    enabled: true,
                                    focusNode: value.mFocusNodeAddress,
                                    controller: value.controllerAddress,
                                    keyboardType: TextInputType.text,
                                    hintText: Constants.STR_ADDRESS.tr,
                                    inputFormatters: const [],
                                    obscureText: false,
                                    onChanged: (String value) {},
                                    suffixIcon: Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.lightGrey,
                                    )),
                                addVerticleSpace(16),
                                //............................Text filedmobile number.............................
                                Stack(
                                  children: [
                                    CustomTextFieldMobile(
                                      strCountyCode: value.strCountyCode,
                                      textInputAction: TextInputAction.done,
                                      readonly: false,
                                      // enabled: false,
                                      //  enabled: true,
                                      height: 42,
                                      controller: value.controllerPhone,
                                      focusNode: value.mFocusNodePhone,
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 4,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                    title: Text('Edit Number'.tr),
                                                    content: TextField(
                                                      controller: value.controllerPhone,
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context, 'Cancel'.tr),
                                                        child: Text('Cancel'.tr),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context, 'OK');
                                                        },
                                                        child: Text('Submit'.tr),
                                                      ),
                                                    ],
                                                  ));
                                        },
                                        child: value.isPhoneVerified && value.oldPhoneNumebr == value.controllerPhone.text
                                            ? Icon(Icons.mobile_friendly,
                                                color: value.isPhoneVerified && value.oldPhoneNumebr == value.controllerPhone.text
                                                    ? Colors.green
                                                    : AppColors.lightGrey)
                                            : SizedBox(
                                                height: 30,
                                                width: 50,
                                                child: PrimaryButton(
                                                  color: null,
                                                  label: Text('Verify'.tr),
                                                  onPress: () {
                                                    gotoMobileOTPScreen(context, value.controllerPhone.text);
                                                  },
                                                ),
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                                addVerticleSpace(AppDimens.dimens_16),
                                //.....................Email Section..................
                                Container(
                                  width: Get.width,
                                  height: AppDimens.dimens_42,
                                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(AppDimens.dimens_10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(value.controllerEmail.text),
                                        Icon(
                                          Icons.mark_email_read_outlined,
                                          size: iconSize,
                                          color: value.isEmailVerified ? Colors.green : AppColors.lightGrey,
                                        ),
                                        // child: Icon(Icons),
                                      ],
                                    ),
                                  ),
                                ),
                                addVerticleSpace(AppDimens.dimens_12),
                                //.........Emargency details section..............
                                Text(
                                  Constants.STR_EMERGENCY_CONTACT_DETAIL.tr,
                                  style: AppStyle.textViewStyleLarge(
                                      context: context, color: AppColors.colorPrimary, fontSizeDelta: 1, fontWeightDelta: 2),
                                ),
                                addVerticleSpace(AppDimens.dimens_12),
                                CustomTextFieldWithIcon(
                                  height: 42,
                                  textInputAction: TextInputAction.next,
                                  enabled: value.isEnableEmgName,
                                  focusNode: value.mFocusNodeEmgName,
                                  controller: value.controllerEmgName,
                                  keyboardType: TextInputType.text,
                                  hintText: Constants.STR_NAME.tr,
                                  inputFormatters: const [],
                                  obscureText: false,
                                  onChanged: (String value) {},
                                  suffixIcon: const InkWell(
                                    child: Icon(
                                      Icons.location_on_outlined,
                                    ),
                                  ),
                                ),
                                addVerticleSpace(AppDimens.dimens_16),
                                CustomTextFieldMobile(
                                  strCountyCode: value.strEmgCountyECode,
                                  textInputAction: TextInputAction.done,
                                  enabled: value.isEnableEmgPhone,
                                  height: 42,
                                  controller: value.controllerEmgPhone,
                                  focusNode: value.mFocusNodeEmgPhone,
                                  suffixIcon: InkWell(
                                    child: Icon(
                                      Icons.phone_android_rounded,
                                      size: iconSize,
                                    ),
                                  ),
                                ),
                                /*--------------------------Add Car Button--------------------------------------*/
                                //profile-------
                                addVerticleSpace(AppDimens.dimens_16),
                                CustomButton(
                                    isGradient: true,
                                    isRoundBorder: true,
                                    height: height,
                                    fontSize: -2,
                                    fontColor: AppColors.colorWhite,
                                    width: size.width,
                                    onPressed: () {
                                      setState(() {
                                        isAddCarTap = true;
                                        //IsAddCarTap =! IsAddCarTap;
                                      });
                                    },
                                    strTitle: "Add Car".tr //Constants.STR_ENTER_YOUR_CAR_DETAILS
                                    ),

                                /*---------------------------------Add Car Inputs File Start---------------------------------------------*/
                                if (isAddCarTap || isEditidTab)
                                  Column(
                                    children: [
                                      addVerticleSpace(AppDimens.dimens_16),

                                      CustomTextFieldWithIcon(
                                        height: 42,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerCarBrand,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_BRAND.tr,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_car, width: iconSize, height: iconSize),
                                      ),
                                      addVerticleSpace(AppDimens.dimens_16),
                                      CustomTextFieldWithIcon(
                                        height: 42,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerCarModelYear,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_MODEL_YEAR.tr,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_car, width: iconSize, height: iconSize),
                                      ),
                                      addVerticleSpace(AppDimens.dimens_16),
                                      CustomTextFieldWithIcon(
                                        height: 42,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerMileage,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_MILEAGE.tr,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_petrol, width: iconSize, height: iconSize),
                                      ),
                                      addVerticleSpace(AppDimens.dimens_16),

                                      CustomTextFieldWithIcon(
                                        height: 42,
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        controller: value.controllerColour,
                                        keyboardType: TextInputType.text,
                                        hintText: Constants.STR_CAR_COLOUR.tr,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                        suffixIcon: Image.asset(AppImages.ic_color, width: iconSize, height: iconSize),
                                      ),
                                      addVerticleSpace(AppDimens.dimens_10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Car Plate Number'.tr,
                                          style: regularText600(15),
                                        ),
                                      ),
                                      addVerticleSpace(AppDimens.dimens_12),
                                      //..........Car plete info row..................//
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: 42,
                                              textInputAction: TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerCode,
                                              keyboardType: TextInputType.text,
                                              hintText: 'Code'.tr,
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                          addHorizontalSpace(5),
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: 42,
                                              textInputAction: TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerCity,
                                              keyboardType: TextInputType.text,
                                              hintText: 'City'.tr,
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                          addHorizontalSpace(5),
                                          Expanded(
                                            child: CustomTextFieldWithIcon(
                                              height: 42,
                                              textInputAction: TextInputAction.next,
                                              enabled: true,
                                              controller: value.controllerNumber,
                                              keyboardType: TextInputType.text,
                                              hintText: 'Number'.tr,
                                              inputFormatters: const [],
                                              obscureText: false,
                                              onChanged: (String value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      addVerticleSpace(16),
                                      // edit butons................
                                      Visibility(
                                        visible: isEditidTab,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: CustomButton(
                                                  isGradient: true,
                                                  isRoundBorder: true,
                                                  height: height,
                                                  fontSize: -2,
                                                  fontColor: AppColors.colorWhite,
                                                  width: size.width,
                                                  onPressed: () {
                                                    controller.clearController();
                                                    setState(() {
                                                      isEditidTab = false;
                                                    });
                                                  },
                                                  strTitle: "Cancel".tr),
                                            ),
                                            const SizedBox(width: 10.0),
                                            SizedBox(
                                              width: 130,
                                              child: CustomButton(
                                                  isGradient: true,
                                                  isRoundBorder: true,
                                                  height: height,
                                                  fontSize: -2,
                                                  fontColor: AppColors.colorWhite,
                                                  width: size.width / 2.2,
                                                  onPressed: () {
                                                    if (value.controllerCarBrand.text.isNotEmpty &&
                                                        value.controllerColour.text.isNotEmpty &&
                                                        value.controllerCarModelYear.text.isNotEmpty &&
                                                        value.controllerMileage.text.isNotEmpty &&
                                                        value.controllerCity.text.isNotEmpty &&
                                                        value.controllerCode.text.isNotEmpty &&
                                                        value.controllerNumber.text.isNotEmpty) {
                                                      controller.updateCar(
                                                        value.controllerCarBrand.text,
                                                        value.controllerColour.text,
                                                        value.controllerCarModelYear.text,
                                                        value.controllerMileage.text,
                                                        value.controllerCity.text,
                                                        value.controllerCode.text,
                                                        value.controllerNumber.text,
                                                        editId!,
                                                      );
                                                      setState(() {
                                                        isAddCarTap = false;
                                                      });
                                                    } else {
                                                      Global.showToastAlert(
                                                          context: Get.overlayContext!,
                                                          strTitle: "",
                                                          strMsg: "Please Fill All Fields",
                                                          toastType: TOAST_TYPE.toastError);
                                                    }
                                                  },
                                                  strTitle: "Update".tr),
                                            ),
                                          ],
                                        ),
                                      ),
                                      addVerticleSpace(12),
                                      Visibility(
                                        visible: !isEditidTab,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: CustomButton(
                                                  isGradient: true,
                                                  isRoundBorder: true,
                                                  height: height,
                                                  fontSize: -2,
                                                  fontColor: AppColors.colorWhite,
                                                  width: size.width,
                                                  onPressed: () {
                                                    controller.clearController();
                                                    setState(() {
                                                      isAddCarTap = false;
                                                    });
                                                  },
                                                  strTitle: "Cancel".tr),
                                            ),
                                            const SizedBox(width: 10.0),
                                            SizedBox(
                                              width: 130,
                                              child: CustomButton(
                                                  isGradient: true,
                                                  isRoundBorder: true,
                                                  height: height,
                                                  fontSize: -2,
                                                  fontColor: AppColors.colorWhite,
                                                  width: size.width / 2.2,
                                                  onPressed: () {
                                                    if (value.controllerCarBrand.text.isNotEmpty &&
                                                        value.controllerColour.text.isNotEmpty &&
                                                        value.controllerCarModelYear.text.isNotEmpty &&
                                                        value.controllerMileage.text.isNotEmpty &&
                                                        value.controllerCity.text.isNotEmpty &&
                                                        value.controllerCode.text.isNotEmpty &&
                                                        value.controllerNumber.text.isNotEmpty) {
                                                      controller.addNewCar(
                                                          value.controllerCarBrand.text,
                                                          value.controllerColour.text,
                                                          value.controllerCarModelYear.text,
                                                          value.controllerMileage.text,
                                                          value.controllerCity.text,
                                                          value.controllerCode.text,
                                                          value.controllerNumber.text);
                                                      setState(() {
                                                        isAddCarTap = false;
                                                      });
                                                    } else {
                                                      Global.showToastAlert(
                                                          context: Get.overlayContext!,
                                                          strTitle: "",
                                                          strMsg: "Please Fill All Fields",
                                                          toastType: TOAST_TYPE.toastError);
                                                    }
                                                  },
                                                  strTitle: Constants.SAVE.tr),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  const SizedBox(),

                                /*---------------------------------Add Car Inputs File Start End---------------------------------------------*/

                                /*---------------------------------Car List----------------------------------------------*/
                                addVerticleSpace(12),

                                controller.carList.isNotEmpty
                                    ? ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        itemCount: controller.carList.length,
                                        itemBuilder: (BuildContext contextM, index) {
                                          GetCarModelResult? mcarlistmodel = controller.carList[index];
                                          return MyCarListItem(
                                              carBrand: mcarlistmodel.brand ?? "",
                                              modeYear: mcarlistmodel.modelYear ?? "",
                                              km: mcarlistmodel.mileage ?? "",
                                              color: mcarlistmodel.color ?? "",
                                              code: mcarlistmodel.carCode ?? "",
                                              city: mcarlistmodel.carCity ?? "",
                                              number: mcarlistmodel.carNumber ?? "",
                                              image: "https://s3.amazonaws.com/cdn.carbucks.com/520e5860-fab9-4d18-904f-919e7cd7667e.png",
                                              onEditTap: () {
                                                value.controllerCarBrand.text = mcarlistmodel.brand ?? "";
                                                value.controllerColour.text = mcarlistmodel.color ?? "";
                                                value.controllerCarModelYear.text = mcarlistmodel.modelYear ?? "";
                                                value.controllerMileage.text = mcarlistmodel.mileage ?? "";
                                                value.controllerCity.text = mcarlistmodel.carCity ?? "";
                                                value.controllerCode.text = mcarlistmodel.carCode ?? "";
                                                value.controllerNumber.text = mcarlistmodel.carNumber ?? "";
                                                setState(() {
                                                  isEditidTab = true;
                                                  editId = mcarlistmodel.id ?? "0";
                                                });
                                                // controller.onTapCategory(mCategoryModel);
                                              },
                                              onDeleteTap: () {
                                                controller.deletecar(mcarlistmodel.id ?? "0");
                                                // });
                                              });
                                        })
                                    : const SizedBox(),

                                /*---------------------------------Car List End------------------------------------------*/
                                addVerticleSpace(12),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    !Global.checkNull(value.imgMulkia)
                                        ? InkWell(
                                            child: Container(
                                              width: size.width / 2.39,
                                              alignment: Alignment.center,
                                              height: imgHeight,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.colorPrimary)),
                                              padding: const EdgeInsets.all(AppDimens.dimens_5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.add_circle_outline_sharp),
                                                  Container(
                                                    child: Text(
                                                      Constants.STR_ADD_MULKIA.tr,
                                                      textAlign: TextAlign.center,
                                                      style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                                                    ),
                                                    margin: const EdgeInsets.only(top: AppDimens.dimens_4),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              value.selectDocs(IdType.mulkia, context);
                                            },
                                          )
                                        : SizedBox(
                                            width: size.width / 2.39,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 2.39,
                                                  child: Global.isURL(value.imgMulkia)
                                                      ? NetworkImageCustom(height: imgHeight, width: size.width / 2.39, image: value.imgMulkia)
                                                      : ImageView(
                                                          strImage: value.imgMulkia,
                                                          height: imgHeight,
                                                          width: size.width / 2.39,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(mColor: AppColors.colorWhite.withOpacity(0.8), mBorderRadius: 5),
                                                        ),
                                                        onTap: () => value.removeImage('mulkia')))
                                              ],
                                            ),
                                          ),
                                    const SizedBox(width: AppDimens.dimens_18),
                                    !Global.checkNull(value.imgDrivingLicence)
                                        ? InkWell(
                                            child: Container(
                                              width: size.width / 2.39,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: AppColors.colorPrimary),
                                              ),
                                              alignment: Alignment.center,
                                              height: imgHeight,
                                              padding: const EdgeInsets.all(AppDimens.dimens_5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.add_circle_outline_sharp),
                                                  Container(
                                                    child: Text(
                                                      Constants.STR_ADD_DRIVING_LICENCE.tr,
                                                      textAlign: TextAlign.center,
                                                      style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                                                    ),
                                                    margin: const EdgeInsets.only(top: AppDimens.dimens_4),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              value.selectDocs(IdType.drivingLicence, context);
                                            },
                                          )
                                        : SizedBox(
                                            width: size.width / 2.39,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 2.39,
                                                  child: Global.isURL(value.imgDrivingLicence)
                                                      ? NetworkImageCustom(
                                                          height: imgHeight, width: size.width / 2.39, image: value.imgDrivingLicence)
                                                      : ImageView(
                                                          strImage: value.imgDrivingLicence,
                                                          height: imgHeight,
                                                          width: size.width / 2.39,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(mColor: AppColors.colorWhite.withOpacity(0.8), mBorderRadius: 5),
                                                        ),
                                                        onTap: () => value.removeImage('driving')))
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                                addVerticleSpace(9),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    !Global.checkNull(value.imgEmIdFront)
                                        ? InkWell(
                                            child: Container(
                                              width: size.width / 2.39,
                                              alignment: Alignment.center,
                                              height: imgHeight,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.colorPrimary)),
                                              padding: const EdgeInsets.all(AppDimens.dimens_5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.add_circle_outline_sharp),
                                                  Container(
                                                    child: Text(
                                                      Constants.STR_ADD_EMIRATES_ID_FRONT.tr,
                                                      textAlign: TextAlign.center,
                                                      style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                                                    ),
                                                    margin: const EdgeInsets.only(top: AppDimens.dimens_4),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              value.selectDocs(IdType.emIdFront, context);
                                            },
                                          )
                                        : SizedBox(
                                            width: size.width / 2.39,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 2.39,
                                                  child: Global.isURL(value.imgEmIdFront)
                                                      ? NetworkImageCustom(height: imgHeight, width: size.width / 2.39, image: value.imgEmIdFront)
                                                      : ImageView(
                                                          strImage: value.imgEmIdFront,
                                                          height: imgHeight,
                                                          width: size.width / 2.39,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(mColor: AppColors.colorWhite.withOpacity(0.8), mBorderRadius: 5),
                                                        ),
                                                        onTap: () => value.removeImage('emirate_front')))
                                              ],
                                            ),
                                          ),
                                    const SizedBox(width: AppDimens.dimens_18),
                                    !Global.checkNull(value.imgEmIdBack)
                                        ? InkWell(
                                            child: Container(
                                              width: size.width / 2.39,
                                              alignment: Alignment.center,
                                              height: imgHeight,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.colorPrimary)),
                                              padding: const EdgeInsets.all(AppDimens.dimens_5),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.add_circle_outline_sharp),
                                                    Container(
                                                      child: Text(
                                                        Constants.STR_ADD_EMIRATES_ID_BACK.tr,
                                                        textAlign: TextAlign.center,
                                                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                                                      ),
                                                      margin: const EdgeInsets.only(top: AppDimens.dimens_4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              value.selectDocs(IdType.emIdBack, context);
                                            },
                                          )
                                        : SizedBox(
                                            width: size.width / 2.39,
                                            height: imgHeight,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                                  ),
                                                  width: size.width / 2.39,
                                                  child: Global.isURL(value.imgEmIdBack)
                                                      ? NetworkImageCustom(height: imgHeight, width: size.width / 2.39, image: value.imgEmIdBack)
                                                      : ImageView(
                                                          strImage: value.imgEmIdBack,
                                                          height: imgHeight,
                                                          width: size.width / 2.39,
                                                        ),
                                                ),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        child: Container(
                                                          child: const Icon(Icons.close),
                                                          decoration:
                                                              AppViews.getColorDecor(mColor: AppColors.colorWhite.withOpacity(0.8), mBorderRadius: 5),
                                                        ),
                                                        onTap: () => value.removeImage('emirate_back')))
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                                addVerticleSpace(12),

                                CustomButton(
                                    isGradient: true,
                                    isRoundBorder: true,
                                    height: height + AppDimens.dimens_4,
                                    fontSize: 0,
                                    fontColor: AppColors.colorWhite,
                                    width: size.width,
                                    onPressed: () {
                                      if (value.isValid(context)) {
                                        value.updateProfile(context);
                                      }
                                    },
                                    strTitle: Constants.STR_UPDATE_YOUR_PROFILE.tr),
                                addVerticleSpace(12),
                              ],
                            ),
                          ),
                        ])),
                      )),
                ),
                GetBuilder<ProfileScreenController>(builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader)),
              ],
            )));
  }

//..................Go to mobile OTP Screen....................................
  void gotoMobileOTPScreen(BuildContext context, String phoneNumber) async {
    // ModelPhoneOTP mModelOTP = ModelPhoneOTP(
    //     phoneNumber: controllerPassword.text.toString(),
    //     otp: controllerEmail.text.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: phoneNumber)));
    // sendOTPTask();
    otpcontroller.sendNumberOTPTask(phoneNumber, context);
    //sentOTPToNumber();
  }

  // Future<void> _displayVerify() async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return WithdrawMoneyDialogBox(
  //           title: 'Verify Phone',
  //           onTap: () {},
  //         );
  //       });
  // }

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
