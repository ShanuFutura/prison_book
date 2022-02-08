import 'package:flutter/material.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/home_page.dart';
import 'package:prisonbook/screens/prison_view_page.dart';
import 'package:prisonbook/screens/profile_edit_screen.dart';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  const PrisonBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        PrisonViewpage.routeName: (ctx) => PrisonViewpage(),
        ProfileEditScreen.routeName: (ctx) => ProfileEditScreen(),
        AttendaceScreen.routeName: (ctx) => AttendaceScreen(),
        AddPrisonerScreen.routeName: (ctx) => AddPrisonerScreen(),
      },
    );
  }
}
