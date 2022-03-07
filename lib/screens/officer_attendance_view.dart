import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
// import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';

class OfficerAttendanceView extends StatelessWidget {
  const OfficerAttendanceView({Key? key}) : super(key: key);

  static const String routeName = 'Officer attnedance view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              'Employees present today..',
              style: TextStyle(fontSize: 17),
            ),
          ),
          const Divider(),
          FutureBuilder(
            future: Provider.of<DBHelper>(context).getAttendanceList(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: (snap.data as List).length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              Provider.of<DBHelper>(context)
                                      .urlForEMployeeImageFetch +
                                  'assets/images/' +
                                  (snap.data as dynamic)[index]['photo']),
                        ),
                        title: Text((snap.data as dynamic)[index]['name']),
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}
