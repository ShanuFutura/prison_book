import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';
import 'package:prisonbook/screens/officers_list_screen.dart';
import 'package:prisonbook/widgets/employee_drawer.dart';
import 'package:prisonbook/widgets/prisons_list_view.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeHomePage extends StatefulWidget {
  EmployeeHomePage({Key? key}) : super(key: key);

  static const String routeName = 'employeehomepage';

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

var punched = true;

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPunched();

  }

  isPunched() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      punched = (pref.getString('attend') ==
          DateFormat('dd/MM/yyyy').format(DateTime.now()));
    });
    // pref.remove('attend');
    
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    // var canPuch = false;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Project Name'),
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/prison_vector.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Theme.of(context).canvasColor
                        ])),
                  )
                ],
              ),
            ),
            pinned: true,
            expandedHeight: fullHeight * .27,
            actions: [
              IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: GestureDetector(
                                onTap: punched
                                    ? null
                                    : () async {
                                        final isDone =
                                            await Provider.of<DBHelper>(context,
                                                    listen: false)
                                                .punchIn();
                                        if (isDone) {
                                          punched = true;
                                          // punched = true;
                                          Navigator.of(context).pop();
                                          Fluttertoast.showToast(
                                              msg: 'attendance registered');
                                          // pref.remove('attend');
                                        } else {
                                          // punched = false;
                                          Fluttertoast.showToast(msg: 'failed');
                                        }
                                      },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Icon(
                                        Icons.verified,
                                        size: 60,
                                        color: punched
                                            ? Colors.blue
                                            : Colors.white,
                                      ),
                                    ),
                                    Text(punched
                                        ? 'already punched'
                                        : 'Punch in'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.event)),
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(OfficersListScreen.routeName),
                  icon: Icon(Icons.local_police)),
            ],
          ),
          SliverFillRemaining(
            child: PrisonsListView(),
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
