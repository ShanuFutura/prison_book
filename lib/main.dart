import 'package:flutter/material.dart';
import 'package:prisonbook/employee_screens/add_prisoner_screen.dart';
import 'package:prisonbook/employee_screens/attendance_screen.dart';
import 'package:prisonbook/employee_screens/employees_list_screen.dart';
import 'package:prisonbook/employee_screens/home_page.dart';
import 'package:prisonbook/employee_screens/login_page.dart';
import 'package:prisonbook/employee_screens/main_prisoner_view.dart';
import 'package:prisonbook/employee_screens/officers_list_screen.dart';
import 'package:prisonbook/employee_screens/profile_edit_screen.dart';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  final copBlue = Color.fromARGB(255, 53, 51, 117);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
      routes: {
        MainPrisonerView.routeName: (ctx) => MainPrisonerView(),
        ProfileEditScreen.routeName: (ctx) => ProfileEditScreen(),
        AttendaceScreen.routeName: (ctx) => AttendaceScreen(),
        AddPrisonerScreen.routeName: (ctx) => AddPrisonerScreen(),
        EmployeesListScreen.routeName: (ctx) => EmployeesListScreen(),
        OfficersListScreen.routeName: (ctx) => OfficersListScreen(),
        LoginPage.routeName: (ctx) => LoginPage(),
        HomePage.routeName: (ctx) => HomePage(),
      },
    );
  }
}
