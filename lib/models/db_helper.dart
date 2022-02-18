import 'dart:io';

import 'package:flutter/cupertino.dart';

class DBHelper extends ChangeNotifier {
  File? profileImage;
  // bool _isDark = true;

  File? getProfileImage() {
    return profileImage;
  }

  // bool isDarkTheme() {
  //   return _isDark;
  // }

  // void toggleTheme() {
  //   _isDark = !_isDark;
  // }
}
