import 'package:flutter/material.dart';
// import 'package:prisonbook/employee_screens/add_prisoner_screen.dart';
// import 'package:prisonbook/employee_screens/attendance_screen.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
// import 'package:prisonbook/employee_screens/main_prisoner_view.dart';
// import 'package:prisonbook/employee_screens/officers_list_screen.dart';

// import 'package:prisonbook/screens/add_prisoner_screen.dart';
// import 'package:prisonbook/screens/attendance_screen.dart';
// import 'package:prisonbook/screens/main_prisoner_view.dart';
// import 'package:prisonbook/screens/officers_list_screen.dart';

import 'package:prisonbook/widgets/employee_drawer.dart';
import 'package:prisonbook/widgets/prisons_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'homepage';

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Project Name'),
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/prison_vector.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Theme.of(context).canvasColor
                        ])),
                  )
                ],
              ),
            ),
            pinned: true,
            expandedHeight: fullHeight * .27,
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AttendaceScreen.routeName),
                  icon: Icon(Icons.event)),
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(OfficersListScreen.routeName),
                  icon: Icon(Icons.local_police)),
            ],
          ),
          SliverFillRemaining(
            child: PrisonsListView(),
          )
        ],
      ),
      drawer: EmployeeDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () =>
            Navigator.of(context).pushNamed(AddPrisonerScreen.routeName),
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}