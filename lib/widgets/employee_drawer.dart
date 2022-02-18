import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
import 'package:prisonbook/screens/profile_edit_screen.dart';
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
    var profileImage = Provider.of<DBHelper>(context).getProfileImage();
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    CircleAvatar(
                        radius: 80,
                        backgroundImage: profileImage == null
                            ? AssetImage('assets/avatar.png') as ImageProvider
                            : FileImage(profileImage)),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(ProfileEditScreen.routeName),
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
            onTap: () =>
                Navigator.of(context).pushNamed(EmployeesListScreen.routeName),
            title: Text('View Employees'),
            trailing: Icon(Icons.reorder),
          ),
          Divider(),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(OfficersListScreen.routeName),
            title: Text('officers'),
            trailing: Icon(Icons.chat),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('feedback'),
            trailing: Icon(Icons.chat),
          ),
          Divider(),
          ListTile(
            onTap: () {
              // Provider.of<DBHelper>(context).toggleTheme();
            },
            title: Text('theme'),
            trailing: Icon(Icons.nightlight),
          ),
          Divider(),
        ],
      ),
    );
  }
}
