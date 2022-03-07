import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prisonbook/models/image_upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBHelper extends ChangeNotifier {
  final String urlS = 'http://192.168.29.78/prison/API/';
  final String urlForEMployeeImageFetch = 'http://192.168.29.78/prison/';

  File? EmployeeProfileImage;

  var userId;

  var employeeList = [];

  var prisonersList = [];

  var prisonerHealthStatus = 'healthy';

  var officersDetails;

  var visitorsList;

//////////////////////////////////////////////////

  fetchAndSetUserId() async {
    final pref = await SharedPreferences.getInstance();
    userId = pref.getString('id');
    print('fetched user id : ' + userId);
  }

  Future<dynamic> fetchPrisonerDetails(String prisonerId) async {
    print('prinsoner id:'+prisonerId);
    final res = await post(Uri.parse(urlS + 'prison_view.php'),
        body: {'prisoner_id': prisonerId});
    print('prison_view:' + res.body);
    if (jsonDecode(res.body) == 'Failed to View') {
      return null;
    } else {
      return jsonDecode(res.body);
    }
  }

  Future<List> fetchAndSetPrisonersList() async {
    final res = await get(Uri.parse(urlS + 'prisoner_list.php'));
    prisonersList = jsonDecode(res.body);
    print('list fetch :' + prisonersList[0]['photo']);

    return prisonersList;
  }

  File? getEmployeeProfileImage() {
    return EmployeeProfileImage;
  }

  Future<String> loginFn(String username, String password) async {
    try {
      final res = await post(Uri.parse(urlS + 'login.php'),
          body: {'username': username, 'password': password});
      print(res.body);

      final pref = await SharedPreferences.getInstance();
      pref.setString('type', jsonDecode(res.body)['type']);
      pref.setString('id', jsonDecode(res.body)['id']);
      // userId = jsonDecode(res.body)['id'];
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
        'emp_id': userId,
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

  Future<bool> feedBackSend(String message) async {
    try {
      final res = await post(Uri.parse(urlS + 'add_feedback.php'),
          body: {'id': userId.toString(), 'feedback': message});
      print(res.body);

      // Fluttertoast.showToast(msg: 'feedback sent');
      print(message);
      return (jsonDecode(res.body)['message'] == 'Successfully added');
    } on Exception catch (error) {
      print(error);
      return false;
    }
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

  reportHealthStatus(String prisonerId, String healthStatus) async {
    try {
      final res = await post(Uri.parse(urlS + 'health_status.php'),
          body: {'prisoner_id': prisonerId, 'status': healthStatus});
      prisonerHealthStatus = healthStatus;
      notifyListeners();
      Fluttertoast.showToast(msg: 'health status updated');
      print(res.body);
    } on Exception catch (err) {
      print(err);
    }
  }

  Future<dynamic> fetchAndSetOfficersList() async {
    final res = await get(Uri.parse(urlS + 'officers_list.php'));
    print('officers list : ' + res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> fetchAndSetEmployeesList() async {
    final res = await get(Uri.parse(urlS + 'employee_list.php'));
    print('employees : ' + res.body);
    return jsonDecode(res.body);
  }

  Future<bool> punchIn() async {
    try {
      final res = await post(Uri.parse(urlS + 'add_attandance.php'), body: {
        'emp_id': userId.toString(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now())
      });
      if (jsonDecode(res.body)['message'] == 'Successfully added') {
        final pref = await SharedPreferences.getInstance();
        pref.setString(
            'attend', DateFormat('dd/MM/yyyy').format(DateTime.now()));
      }
      print('attend________' + res.body);
      return (jsonDecode(res.body)['message'] == 'Successfully added');
    } on Exception catch (error) {
      return false;
    }
  }

  Future<bool> addPrisoner({
    required String name,
    required String crime,
    required DateTime entry_date,
    required DateTime releasing_date,
    required String age,
    required String address,
    required String cell_no,
    required String gender,
    required File imageFile,
    required String section,
  }) async {
    final res = await ImageUpload.upload(
        imageFile: imageFile,
        url: Uri.parse(urlS + 'prisoner_add.php'),
        name: name,
        crime: crime,
        entryDate: entry_date,
        releaseDate: releasing_date,
        age: age,
        address: address,
        cellNo: cell_no,
        gender: gender,
        section: section);
    // final res = await post(
    //     Uri.parse(
    //       urlS + 'prisoner_add.php',
    //     ),
    //     body: {
    //       'prisoner_name': name,
    //       'crime': crime,
    //       'entry_date': DateFormat('dd/mm/yyyy').format(entry_date),
    //       'releasing_date': DateFormat('dd/mm/yyyy').format(releasing_date),
    //       'age': age.toString(),
    //       'address': address,
    //       'cell_no': cell_no,
    //       'gender': gender,
    //       'f1': '',
    //     });
    // print(res.body);
    return res;
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final tempImageFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    final imageFile = File(tempImageFile!.path);
    print(imageFile.path);
    return imageFile;
  }

  Future<dynamic> getParolsList() async {
    final res = await get(Uri.parse(urlS + 'parole_list.php'));
    print('........' + res.body);

    return jsonDecode(res.body);
  }

  Future<dynamic> getMaliciousList() async {
    final res = await get(Uri.parse(urlS + 'mal_activity_list.php'));
    print('malicious : ' + res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> getAttendanceList() async {
    final res = await get(Uri.parse(urlS + 'attandance_list.php'));
    print('attendance : ' + res.body);
    return jsonDecode(res.body);
  }

  Future<dynamic> fetchOfficersDetails() async {
    final res = await post(Uri.parse(urlS + 'officer_view.php'),
        body: {'officer_id': '5'});
    print('officers details' + res.body);
    officersDetails = jsonDecode(res.body);
  }

  Future<void> updateOfficerProfile(
      String name, int age, String address, String email, String mobile) async {
    final res =
        await post(Uri.parse(urlS + 'insert_updated_officer.php'), body: {
      'officer_id': '2',
      'officer_name': name,
      'age': age.toString(),
      'address': address,
      'email_id': email,
      'mobile_number': mobile,
    });
    print(res.body);
  }

  Future<dynamic> getVisitorsList(String prisonerId) async {
    final res = await post(Uri.parse(urlS + 'visitors_list.php'),
        body: {'prisoner_id': prisonerId});
        if(jsonDecode(res.body)['message']!='failed'){

    visitorsList = jsonDecode(res.body);
        }
    print('visitors' + res.body);
    return jsonDecode(res.body);
  }
}
