import 'package:flutter/material.dart';
// import 'package:prisonbook/models/dummyDatas.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
// import 'package:prisonbook/screens/prison_view_page.dart';
import 'package:prisonbook/widgets/employee_drawer.dart';

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
                children: [
                  Container(
                    height: 500,
                    child: Image.asset(
                      'assets/prison_vector.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Color.fromRGBO(48, 48, 48, 1)
                        ])),
                  )
                ],
              ),
            ),
            pinned: true,
            expandedHeight: 200,
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
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    title: Text('Prisoner Name'),
                    subtitle: Text('prisoner number'),
                    trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MainPrisonerView.routeName);
                        },
                        child: Text('View')),
                  );
                }),
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
