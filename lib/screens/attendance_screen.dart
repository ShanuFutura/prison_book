import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendaceScreen extends StatelessWidget {
  const AttendaceScreen({Key? key}) : super(key: key);

  static const String routeName = 'attnedance screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('date'),
            );
          }),
      // Column(
      //   children: [
      //     TableCalendar(
      //         eventLoader: (day) {
      //           return [day];
      //         },
      //         focusedDay: DateTime.now(),
      //         firstDay: DateTime.now().subtract(Duration(days: 7)),
      //         lastDay: DateTime.now().add(Duration(days: 7))),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add_task),
      // ),
    );
  }
}
