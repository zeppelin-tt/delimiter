import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Notifications {
  static error(BuildContext context, String error, double allMargin, double borderRadius) {
    Flushbar(
      icon: Icon(Icons.error, color: Colors.red, size: 20.0),
      margin: EdgeInsets.all(allMargin),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.grey[800],
      borderRadius: borderRadius,
      title: 'Attention!',
      message: error,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
