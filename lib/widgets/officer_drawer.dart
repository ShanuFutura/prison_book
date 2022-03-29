// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/feedback_screen.dart';
import 'package:prisonbook/screens/login_page.dart';
import 'package:prisonbook/screens/officer_attendance_view.dart';
// import 'package:prisonbook/screens/officer_home_page.dart';
import 'package:prisonbook/screens/officer_profile_edit_screen.dart';
import 'package:prisonbook/screens/parol_list.dart';
import 'package:prisonbook/screens/prisoner_transfer_screen.dart';
import 'package:provider/provider.dart';
// import 'package:prisonbook/widgets/employee_list.dart';

class OfficerDrawer extends StatelessWidget {
  const OfficerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? profileImage =
        Provider.of<DBHelper>(context).officersDetails == null
            ? null
            : Provider.of<DBHelper>(context).officersDetails['photo'];
    return Drawer(
      child: Column(
        children: [
          Container(
            // height: 300,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: profileImage != null
                          ? NetworkImage(Provider.of<DBHelper>(context)
                                  .urlForEMployeeImageFetch +
                              'assets/images/' +
                              profileImage) as ImageProvider
                          : AssetImage(
                              'assets/avatar.png',
                            ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(OfficerProfileEditScreen.routeName);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Employees'),
            trailing: Icon(Icons.badge),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EmployeesListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Attendance'),
            trailing: Icon(Icons.calendar_today),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OfficerAttendanceView.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Parols'),
            trailing: Icon(Icons.meeting_room),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ParolList.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Transfers'),
            trailing: Icon(Icons.local_shipping),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(PrisonerTransferScreen.routeName);
              // Navigator.push(context, MaterialPageRoute(builder: Empl));
            },
          ),
          Divider(),
          ListTile(
            title: Text('feedback'),
            trailing: Icon(Icons.feedback),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FeedBackScreen.routeName);
              // Navigator.push(context, MaterialPageRoute(builder: Empl));
            },
          ),
          Divider(),
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
    );
  }
}
