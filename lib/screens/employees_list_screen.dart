import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class EmployeesListScreen extends StatelessWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  static const String routeName = 'employee list screen';

  @override
  Widget build(BuildContext context) {
    final empList = Provider.of<DBHelper>(context).employeeList;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: empList.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text(empList[index]['prisoner_name']),
                  // subtitle: Text('subtitle'),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
