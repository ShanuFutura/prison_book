import 'dart:io';

import 'package:flutter/cupertino.dart';

class DBHelper extends ChangeNotifier {
  File? profileImage;

  File? getProfileImage() {
    return profileImage;
  }
}
