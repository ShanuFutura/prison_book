import 'dart:io';

import 'package:flutter/cupertino.dart';

class DBHelper extends ChangeNotifier {
  File? EmployeeProfileImage;

  File? officerProfileImage;

  File? getEmployeeProfileImage() {
    return EmployeeProfileImage;
  }

  File? getOfficerProfileImage() {
    // notifyListeners();
    return officerProfileImage;
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
