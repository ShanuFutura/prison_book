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
      body: FutureBuilder(
          future: Provider.of<DBHelper>(context).fetchAndSetEmployeesList(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(),
                          title: Text((snap.data as dynamic)[index]['name']),
                          subtitle: Text(
                              (snap.data as dynamic)[index]['mobile_number']),
                          // subtitle: Text('subtitle'),
                        ),
                        Divider()
                      ],
                    );
                  });
            } else {
              return Center(
                child: Text('Something wrong'),
              );
            }
          }),
    );
  }
}
