import 'package:flutter/material.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:table_calendar/table_calendar.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TableCalendar(
            eventLoader: (day) {
              return [day];
            },
            focusedDay: DateTime.now(),
            firstDay: DateTime.now().subtract(Duration(days: 7)),
            lastDay: DateTime.now().add(Duration(days: 7)),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('employees by date attendance'),
                  );
                }),
          )
        ],
      ),
    );
  }
}
