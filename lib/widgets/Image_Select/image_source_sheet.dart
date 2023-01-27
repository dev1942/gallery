import 'package:flutter/material.dart';

Widget imageSouceSheet({
  required VoidCallback onCameraPressed,
  required VoidCallback onGalleryPressed,
  required BuildContext context,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Theme.of(context).primaryColor,
          Colors.red,
        ],
      ),
    ),
    child: SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.camera_enhance,
              color: Colors.white,
            ),
            title: Text(
              "CAMERA",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            ),
            onTap: onCameraPressed,
          ),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
              leading: const Icon(
                Icons.image,
                color: Colors.white,
              ),
              title: Text(
                "GALLERY",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              ),
              onTap: onGalleryPressed)
        ],
      ),
    ),
  );
}
