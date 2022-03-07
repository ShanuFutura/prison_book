import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prisonbook/models/db_helper.dart';

import 'package:prisonbook/screens/add_prisoner_screen.dart';

import 'package:prisonbook/widgets/prisoner_view_drawer.dart';
import 'package:prisonbook/widgets/prisoner_view_sliver_appbar.dart';
import 'package:provider/provider.dart';

class MainPrisonerView extends StatelessWidget {
  // const MainPrisonerView({Key? key}) : super(key: key);

  static const String routeName = 'main prisoner view';

  var snapForAppBar;

  var prisonerId;

  healthDialogCard(BuildContext context) {
    var prisonerHealth =
        Provider.of<DBHelper>(context, listen: false).prisonerHealthStatus;
    // var healthStatus;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: ['critical', 'not well', 'healthy'].map(
              (e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<DBHelper>(context, listen: false)
                              .reportHealthStatus(prisonerId, e);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.offline_pin,
                          color:
                              prisonerHealth == e ? Colors.blue : Colors.grey,
                        )),
                    Text(e)
                  ],
                );
              },
            ).toList(),
          ));
        });
  }

  maliciouseShowDialog(BuildContext context) {
    final malController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Builder(builder: (context) {
            return Dialog(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    color: Colors.black.withOpacity(.1),
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          label: Text('malicious activity type')),
                      // keyboardType: TextInputType.number,
                      controller: malController,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ElevatedButton(onPressed: () {}, child: Text('date')),
                      IconButton(
                          onPressed: () async {
                            print(malController.text);
                            final res = await Provider.of<DBHelper>(context,
                                    listen: false)
                                .reportMaliciousActivity(
                                    prisonerId, malController.text);
                            if (res == 'Successfully reported') {
                              Fluttertoast.showToast(
                                  msg: 'added malicious activity');
                              Navigator.of(context).pop();
                            }
                          },
                          icon: Icon(Icons.done)),
                    ],
                  ),
                ],
              ),
            ));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    prisonerId = ModalRoute.of(context)!.settings.arguments;
    // prisonerHealth = Provider.of<DBHelper>(context).prisonerHealthStatus;

    return Scaffold(
      drawer: PrisonerViewDrawer(
        maliciousFn: maliciouseShowDialog,
        prisonerHealthFn: healthDialogCard,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).errorColor,
        onPressed: () {
          maliciouseShowDialog(context);
        },
        child: Icon(Icons.report),
      ),
      body: FutureBuilder(
          future:
              Provider.of<DBHelper>(context).fetchPrisonerDetails(prisonerId),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              snapForAppBar = snap;
              return CustomScrollView(slivers: [
                SliverAppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          healthDialogCard(context);
                        },
                        icon: Icon(Icons.health_and_safety)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AddPrisonerScreen.routeName);
                        },
                        icon: Icon(Icons.edit))
                  ],
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: PrisonerViewSliverAppbar(snap.data as Map),
                ),
                SliverFillRemaining(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text('Crime'),
                            const SizedBox(width: 30),
                            Chip(label: Text((snap.data as Map)['crime']))
                          ],
                        ),
                      ),
                      ListTile(
                          title: Row(
                        children: [
                          Text('Section'),
                          const SizedBox(width: 30),
                          Chip(label: Text((snap.data as Map)['section_no']))
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text('entry'),
                                  SizedBox(width: deviceWidth * .04),
                                  Chip(
                                      label: Text(
                                          (snap.data as Map)['entry_date']))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text('release'),
                                  SizedBox(width: deviceWidth * .04),
                                  Chip(
                                      label: Text(
                                          (snap.data as Map)['releasing_date']))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 200,
                          width: deviceWidth * .95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 255, 255, .2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'address',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text((snap.data as Map)['address']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(10),
                      //       child: Text('Parole'),
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         Text('from'),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Chip(
                      //               label: Text(
                      //                   (snap.data as Map)['starting_date'])),
                      //         ),
                      //         Text('to'),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Chip(
                      //             label: Text(
                      //                 (snap.data as Map)['rejoining_date']),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Transfer'),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(label: Text('                '))),
                          ],
                        ),
                      ),
                      Divider(),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'visitors',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: Provider.of<DBHelper>(context)
                              .getVisitorsList(prisonerId),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snap.hasData) {
                                final visitors =
                                    Provider.of<DBHelper>(context).visitorsList;
                                return Container(
                                  height: 300,
                                  width: deviceWidth * .9,
                                  child: ListView.builder(
                                    itemCount: (visitors as List).length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/avatar.png'),
                                        ),
                                        title: Text(
                                            visitors[index]['visitor_name']),
                                        subtitle: Text(
                                            visitors[index]['visiting_date']),
                                        trailing: Text(
                                            visitors[index]['visiting_time']),
                                      );
                                    }),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text('no data available'),
                                );
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ]);
            } else {
              return Center(
                child: Text('Something went wrong'),
              );
            }
          }),
    );
  }
}
