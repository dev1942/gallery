import 'package:flutter/material.dart';

class ContainerProperties {
  static BoxDecoration shadowDecoration(
      {double radius = 5.0, double blurRadius = 6.0}) {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              offset: const Offset(0, 0),
              blurRadius: blurRadius),
        ]);
  }

  static BoxDecoration simpleDecoration({double radius = 5.0}) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
