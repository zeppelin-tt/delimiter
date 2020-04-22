import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications {
  static error(BuildContext context, String error) {
    Flushbar(
      icon: Icon(Icons.error, color: Colors.red, size: 20.0),
      margin: EdgeInsets.all(12.w),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.grey[800],
      borderRadius: 6.w,
      title: 'Attention!',
      message: error,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
