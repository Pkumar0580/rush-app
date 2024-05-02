import 'package:flutter/services.dart';

class AppColor {
  static const btnColor = Color(0xffFF7918);
  static const backgroundColor = Color(0xffFFFAF4);
  static const appbarColor = Color(0xff133964);
  static const statusBarColor = Color(0xff0D2949);
  static const primaryColor = Color(0xff000000);
}

void statusBarColorChange(Color statusBarColor) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    systemNavigationBarColor: statusBarColor,
  ));
}
