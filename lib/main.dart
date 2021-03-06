import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';

// import 'package:prisonbook/employee_screens/attendance_screen.dart';

import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/employee_home_page.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/feedback_screen.dart';
import 'package:prisonbook/screens/loading_page.dart';
import 'package:prisonbook/screens/login_page.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:prisonbook/screens/malicious_activity_screen.dart';
import 'package:prisonbook/screens/officer_attendance_view.dart';
import 'package:prisonbook/screens/officer_home_page.dart';
import 'package:prisonbook/screens/officer_profile_edit_screen.dart';
// import 'package:prisonbook/screens/officer_home_page.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
import 'package:prisonbook/screens/parol_list.dart';
import 'package:prisonbook/screens/employee_profile_edit_screen.dart';
import 'package:prisonbook/screens/prisoner_transfer_screen.dart';
// import 'package:prisonbook/widgets/prisons_list_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferance/';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  final copBlue = Color.fromARGB(255, 53, 51, 117);
  @override
  Widget build(BuildContext context) {
    Future<String?> getType() async {
      final pref = await SharedPreferences.getInstance();
      return pref.getString('type');
    }

    return ChangeNotifierProvider(
      create: (context) => DBHelper(),
      // builder: (context){},
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: FutureBuilder(
            future: getType(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                print('waiting...');
                LoadingPage();
              } else if (snap.data == 'officer') {
                print('officer detected');
                
                Provider.of<DBHelper>(context).fetchOfficersDetails();
                return OfficerHomePage();
              } else if (snap.data == 'employeee') {
                print('employee detected');
                // Provider.of<DBHelper>(context).fetchAndSetPrisonersList();
                Provider.of<DBHelper>(context).fetchAndSetUserId();
                // Provider.of<DBHelper>(context).fetchAndSetOfficersList();
                return EmployeeHomePage();
              } else {
                return LoginPage();
              }
              return LoginPage();
            }),
        routes: {
          MainPrisonerView.routeName: (ctx) => MainPrisonerView(),
          EmployeeProfileEditScreen.routeName: (ctx) =>
              EmployeeProfileEditScreen(),
          AttendaceScreen.routeName: (ctx) => AttendaceScreen(),
          AddPrisonerScreen.routeName: (ctx) => AddPrisonerScreen(),
          EmployeesListScreen.routeName: (ctx) => EmployeesListScreen(),
          OfficersListScreen.routeName: (ctx) => OfficersListScreen(),
          LoginPage.routeName: (ctx) => LoginPage(),
          OfficerHomePage.routeName: (ctx) => OfficerHomePage(),
          // EmployeesListScreen.routeName: (ctx) => EmployeesListScreen(),
          OfficerProfileEditScreen.routeName: (ctx) =>
              OfficerProfileEditScreen(),
          OfficerAttendanceView.routeName: (ctx) => OfficerAttendanceView(),
          MaliciousActivityListScreen.routeName: (ctx) =>
              MaliciousActivityListScreen(),
          ParolList.routeName: (ctx) => ParolList(),
          FeedBackScreen.routeName: (ctx) => FeedBackScreen(),
          EmployeeHomePage.routeName: (ctx) => EmployeeHomePage(),
          PrisonerTransferScreen.routeName: (context) =>
              PrisonerTransferScreen(),
        },
      ),
    );
  }
}
