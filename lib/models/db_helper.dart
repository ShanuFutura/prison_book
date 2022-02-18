import 'dart:io';

import 'package:flutter/cupertino.dart';

class DBHelper extends ChangeNotifier {
  File? profileImage;

  File? getProfileImage() {
    return profileImage;
  }

  loginFn(String username, String password) {
    print(username);
    print(password);
  }

  employeeProfileEdit(
    String name,
    String age,
    String address,
    String gender,
    String phone,
    String email,
    // File photo,
  ) {
    print('{$name,$age,$address,$gender,$phone,$email}');
  }

  feedBackSend(String message) {
    print(message);
  }
}
