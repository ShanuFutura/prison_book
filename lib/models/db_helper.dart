import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBHelper extends ChangeNotifier {
  final String urlS = 'http://192.168.29.77/prison/API/';

  File? EmployeeProfileImage;

  File? officerProfileImage;

  var employeeId;

  var employeeList = [];

  var prisonersList = [];

//////////////////////////////////////////////////

  fetchAndSetEmpId() async {
    final pref = await SharedPreferences.getInstance();
    employeeId = pref.getString('id');
    print('fetched id : ' + employeeId);
  }

  Future<dynamic> fetchPrisonerDetails() async {
    final res = await post(Uri.parse(urlS + 'prison_view.php'),
        body: {'prisoner_id': '1'});
    print(res.body);
    return jsonDecode(res.body);
  }

  Future<void> fetchAndSetPrisonersList() async {
    final res = await get(Uri.parse(urlS + 'prisoner_list.php'));
    prisonersList = jsonDecode(res.body);
    print('list fetch :' + prisonersList.toString());
    // return prisonersList as List<Map>;
    // notifyListeners();
  }

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
      pref.setString('id', jsonDecode(res.body)['id']);
      // employeeId = jsonDecode(res.body)['id'];
      return jsonDecode(res.body)['type'];
    } on Exception catch (error) {
      print(error);
      return 'error';
    }
  }

  Future<String> employeeProfileEdit(
    String name,
    String age,
    String address,
    String gender,
    String phone,
    String email,
    // File photo,
  ) async {
    try {
      final res = await post(Uri.parse(urlS + 'insert_updated_emp.php'), body: {
        'emp_id': employeeId,
        'emp_name': name,
        'age': age,
        'address': address,
        'email_id': email,
        'gender': gender,
        'mobile_number': phone,
      });
      print((res.body));
      // return jsonDecode(res.body)['message'];
      if (jsonDecode(res.body)['message'] == "Successfully Updated") {
        return "successfully Updated";
      } else
        return "something went wrong";
    } on Exception catch (err) {
      print(err);
      return 'something went wrong';
    }
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

  Future<String> reportMaliciousActivity(
      String prisonerId, String activity) async {
    final res = await post(Uri.parse(urlS + 'report.php'), body: {
      'prisoner_id': prisonerId,
      'activity': activity,
      'date': DateFormat('dd/mm/yyyy').format(DateTime.now())
    });
    print(res.body);
    return jsonDecode(res.body)['message'];
  }
}
