import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// ignore: library_prefixes
import 'package:location/location.dart' as LocationM;
import 'package:otobucks/global/constants.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/app_dimens.dart';
import '../global/enum.dart';
import '../global/global.dart';

// ignore: must_be_immutable
class GoogleMapView extends StatefulWidget {
  Function onTap;

  GoogleMapView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  GoogleMapViewState createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  LocationM.Location location = LocationM.Location();
  late LocationData? currentLocation;
  final Set<Marker> _markers = <Marker>{};

  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  CameraPosition initialLocation = CameraPosition(
    target: Global.mLatLng,
    zoom: 11.00,
  );

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          child: GoogleMap(
            onCameraIdle: () {},
            mapType: MapType.normal,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: initialLocation,
            onMapCreated: _onMapCreated,
            markers: _markers,
          )),
    );
  }

  @override
  void dispose() {
    //timer.cancel();
    super.dispose();
  }

  getLocation() async {
    await Permission.location.request();

    final prefManager = await SharedPreferences.getInstance();
    LatLng mLatLng_ = Global.mLatLng;
    try {
      double? mLatitude = prefManager.getDouble(SharedPrefKey.KEY_APP_LATITUDE);
      double? mLongitude =
          prefManager.getDouble(SharedPrefKey.KEY_APP_LONGITUDE);

      if (mLatitude != null && mLongitude != null) {
        mLatLng_ = LatLng(mLatitude, mLongitude);
      }

      var requestPermission = await Permission.location.status;

      if (requestPermission.isDenied) {
        var _permissionStatus = await Permission.location.status;
        switch (_permissionStatus) {
          case permission_handler.PermissionStatus.denied:
            Global.showToastAlert(
                context: context,
                strTitle: "",
                strMsg: AppAlert.STRING_ALLOW_LOCATION_ACCESS,
                toastType: TOAST_TYPE.toastWarning);
            return "";
          case permission_handler.PermissionStatus.granted:
            getLocation();
            return "";
          case permission_handler.PermissionStatus.limited:
            getLocation();
            return "";
          default:
            return "";
        }
      } else if (requestPermission.isGranted || requestPermission.isLimited) {
        currentLocation = await location.getLocation();

        if (currentLocation != null) {
          mLatLng_ =
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
        }
      }

      prefManager.setDouble(SharedPrefKey.KEY_APP_LATITUDE, mLatLng_.latitude);
      prefManager.setDouble(
          SharedPrefKey.KEY_APP_LONGITUDE, mLatLng_.longitude);

      _markers.clear();

      // await Future.delayed(Duration(seconds: 2));
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: mLatLng_,
            zoom: 12,
          ),
        ),
      );
      _markers.add(Marker(
        markerId: MarkerId(_markers.length.toString()),
        position: mLatLng_,
        infoWindow: InfoWindow(
            title: "My Location",
            snippet: "My Location",
            onTap: () {
              // _showPreferenceSheet();
            }),
        // icon: myLocationIcon,
      ));
      widget.onTap(mLatLng_);
      setState(() {});
      await location.getLocation();
    } catch (e) {
      currentLocation = null;
      // openSettingsMenu();
    }
  }
}
