import 'package:flutter/material.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/home_page.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
// import 'package:stacked_themes/stacked_themes.dart';

import 'package:prisonbook/screens/profile_edit_screen.dart';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  final copBlue = Color.fromRGBO(52, 51, 82, 1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   iconTheme: IconThemeData(
      //     color: Colors.white,
      //   ),
      //   canvasColor: copBlue,
      //   scaffoldBackgroundColor: const Color.fromRGBO(125, 125, 125, 1),
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //       backgroundColor: Color.fromRGBO(39, 71, 41, 1)),
      //   primaryColorDark: copBlue,
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //       style: ButtonStyle(
      //           backgroundColor: MaterialStateProperty.all(copBlue))),
      //   primaryColor: copBlue,
      //   appBarTheme: AppBarTheme(
      //     color: copBlue,
      //   ),
      //   drawerTheme: DrawerThemeData(
      //     backgroundColor: copBlue,
      //     scrimColor: copBlue,
      //   ),
      //   shadowColor: Colors.black,
      //   buttonColor: copBlue,
      //   cursorColor: copBlue,
      //   errorColor: Colors.red,
      //   cardColor: copBlue,
      //   textTheme: const TextTheme(
      //     headline5: TextStyle(color: Colors.white),
      //     bodyText2: TextStyle(color: Colors.white),
      //     overline: TextStyle(color: Colors.white),
      //     subtitle2: TextStyle(color: Colors.white),
      //     button: TextStyle(color: Colors.white),
      //     headline1: TextStyle(color: Colors.white),
      //     subtitle1: TextStyle(color: Colors.white),
      //     caption: TextStyle(color: Colors.white),
      //     headline6: TextStyle(color: Colors.white),
      //     bodyText1: TextStyle(color: Colors.white),
      //   ),
      // ),
      home: HomePage(),
      routes: {
        MainPrisonerView.routeName: (ctx) => MainPrisonerView(),
        ProfileEditScreen.routeName: (ctx) => ProfileEditScreen(),
        AttendaceScreen.routeName: (ctx) => AttendaceScreen(),
        AddPrisonerScreen.routeName: (ctx) => AddPrisonerScreen(),
        EmployeesListScreen.routeName: (ctx) => EmployeesListScreen(),
        OfficersListScreen.routeName: (ctx) => OfficersListScreen()
      },
    );
  }
}
