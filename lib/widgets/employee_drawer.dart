import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/feedback_screen.dart';
import 'package:prisonbook/screens/login_page.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
import 'package:prisonbook/screens/employee_profile_edit_screen.dart';
import 'package:prisonbook/screens/parol_list.dart';
import 'package:prisonbook/screens/prisoner_transfer_screen.dart';
import 'package:provider/provider.dart';
// import 'package:prisonbook/employee_screens/employees_list_screen.dart';
// import 'package:prisonbook/employee_screens/officers_list_screen.dart';
// import 'package:prisonbook/employee_screens/profile_edit_screen.dart';
// import 'package:prisonbook/screens/employees_list_screen.dart';
// import 'package:prisonbook/screens/officers_list_screen.dart';
// import 'package:prisonbook/screens/profile_edit_screen.dart';

class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileImage = Provider.of<DBHelper>(context).getEmployeeProfileImage();
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.indigo,
                    Theme.of(context).canvasColor,
                  ])),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.bottomRight, children: [
                      FutureBuilder(
                          future: Provider.of<DBHelper>(context)
                              .getProfileDetailsToView(),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return const CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage('assets/avatar.png')
                                          as ImageProvider);
                            } else if (snap.connectionState ==
                                ConnectionState.done) {
                              return CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      Provider.of<DBHelper>(context)
                                              .urlForEMployeeImageFetch +
                                          'assets/images/' +
                                          (snap.data as Map)['photo']));
                            } else {
                              return const CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage('assets/avatar.png')
                                          as ImageProvider);
                            }
                          }),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(EmployeeProfileEditScreen.routeName),
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                    Text('User Name')
                  ],
                ),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(EmployeesListScreen.routeName),
              title: Text('View Employees'),
              trailing: Icon(Icons.reorder),
            ),
            Divider(),
            ListTile(
              onTap: () =>
                  Navigator.of(context).pushNamed(OfficersListScreen.routeName),
              title: Text('officers'),
              trailing: Icon(Icons.local_police),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(ParolList.routeName);
              },
              title: Text('parole list'),
              trailing: Icon(Icons.door_front_door_outlined),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(PrisonerTransferScreen.routeName);
              },
              title: Text('Prisoner transfers'),
              trailing: Icon(Icons.local_shipping),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(FeedBackScreen.routeName);
              },
              title: Text('feedback'),
              trailing: Icon(Icons.chat),
            ),
            Divider(),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(AttendaceScreen.routeName);
            //   },
            //   title: Text('Attendance'),
            //   trailing: Icon(Icons.event),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () {},
            //   title: Text('Critical health prisoners'),
            //   trailing: Icon(Icons.medical_services),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () {
            //     // Provider.of<DBHelper>(context).toggleTheme();
            //   },
            //   title: Text('theme'),
            //   trailing: Icon(Icons.nightlight),
            // ),
            // Divider(),
            ListTile(
              title: Text('logout'),
              trailing: Icon(Icons.logout),
              onTap: () {
                Provider.of<DBHelper>(context, listen: false).logout();

                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(LoginPage.routeName);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
