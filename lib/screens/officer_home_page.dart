import 'package:flutter/material.dart';
import 'package:prisonbook/screens/attendance_screen.dart';
import 'package:prisonbook/screens/employees_list_screen.dart';
import 'package:prisonbook/screens/malicious_activity_screen.dart';
import 'package:prisonbook/screens/officer_attendance_view.dart';
// import 'package:flutter/widgets.dart';
import 'package:prisonbook/widgets/officer_drawer.dart';
import 'package:prisonbook/widgets/prisons_list_view.dart';

class OfficerHomePage extends StatelessWidget {
  const OfficerHomePage({Key? key}) : super(key: key);
  static const String routeName = 'officerhome page';

  @override
  Widget build(BuildContext context) {
    var fullHeight =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    return Scaffold(
      drawer: OfficerDrawer(),
      appBar: AppBar(
        title: Text('Prisonbook'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: fullHeight * .27,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(EmployeesListScreen.routeName);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromARGB(255, 122, 122, 122),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.badge,
                              size: 50,
                            ),
                            Text(
                              'Employees',
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MaliciousActivityListScreen.routeName);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromARGB(255, 122, 122, 122),
                        ),
                        // color: Color.fromARGB(255, 70, 244, 54),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.report,
                              size: 50,
                            ),
                            Text(
                              'Malicious activity',
                              style: TextStyle(fontSize: 19),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(OfficerAttendanceView.routeName);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 122, 122, 122)),
                        // color: Color.fromARGB(255, 105, 54, 244),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              size: 50,
                            ),
                            Text(
                              'Attendance',
                              style: TextStyle(fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(height: fullHeight * .65, child: PrisonsListView()),
        ],
      ),
    );
  }
}
