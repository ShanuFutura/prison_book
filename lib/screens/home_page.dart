import 'package:flutter/material.dart';
// import 'package:prisonbook/models/dummyDatas.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
// import 'package:prisonbook/screens/prison_view_page.dart';
import 'package:prisonbook/widgets/employee_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AttendaceScreen.routeName),
              icon: Icon(Icons.event)),
          IconButton(onPressed: () {}, icon: Icon(Icons.local_police)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 200),
          Container(
            alignment: Alignment.bottomCenter,
            height: fullHeight / 2,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text('title'),
                    trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MainPrisonerView.routeName);
                        },
                        child: Text('test')),
                  );
                }),
          ),
        ],
      ),
      drawer: EmployeeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddPrisonerScreen.routeName),
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
