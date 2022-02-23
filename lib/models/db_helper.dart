import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBHelper extends ChangeNotifier {
  final String urlS = 'http://192.168.29.77/prison/API/';

  File? EmployeeProfileImage;

  File? officerProfileImage;

  var employeeId;

  File? getEmployeeProfileImage() {
    return EmployeeProfileImage;
  }

  File? getOfficerProfileImage() {
    // notifyListeners();
    return officerProfileImage;
  }

  Future<String> loginFn(String username, String password) async {
    try {
      final res = await post(Uri.parse(urlS + 'login.php'),
          body: {'username': username, 'password': password});
      print(res.body);

      final pref = await SharedPreferences.getInstance();
      pref.setString('type', jsonDecode(res.body)['type']);
      employeeId = jsonDecode(res.body)['type'];
      return jsonDecode(res.body)['type'];
    } on Exception catch (error) {
      print(error);
      return 'error';
    }
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

  logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<dynamic> getProfileDetailsToView() async {
    // print('test');
    final res =
        await post(Uri.parse(urlS + 'update.php'), body: {'emp_id': '2'});
    print('res........' + (jsonDecode(res.body)).toString());
    return jsonDecode(res.body);
  }
}
