import 'package:flutter/material.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/home_page.dart';
import 'package:prisonbook/screens/login_page.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';

import 'package:prisonbook/screens/profile_edit_screen.dart';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  final copBlue = Color.fromRGBO(52, 51, 82, 1);
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
