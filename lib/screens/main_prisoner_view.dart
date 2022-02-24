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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 'x', groupValue: 0, onChanged: (v) {}),
                  Text('critical'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 'x', groupValue: 0, onChanged: (v) {}),
                  Text('not well'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 'x', groupValue: 0, onChanged: (v) {}),
                  Text('healthy'),
                ],
              ),
            ],
          ));
        });
  }

  maliciouseShowDialog(BuildContext context) {
    var activity;
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton(
                    hint: Text('malicious act type'),
                    items: const [
                      DropdownMenuItem(
                        child: Text('prison break attempt'),
                        value: 'prison break attempt',
                      ),
                      DropdownMenuItem(
                        child: Text('violence'),
                        value: 'violence',
                      ),
                      DropdownMenuItem(
                        child: Text('theft'),
                        value: 'theft',
                      ),
                    ],
                    onChanged: (val) {
                      activity = val;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ElevatedButton(onPressed: () {}, child: Text('date')),
                    IconButton(
                        onPressed: () async {
                          final res = await Provider.of<DBHelper>(context,
                                  listen: false)
                              .reportMaliciousActivity(prisonerId, activity);
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
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    prisonerId = ModalRoute.of(context)!.settings.arguments;

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
          future: Provider.of<DBHelper>(context).fetchPrisonerDetails(),
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
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              title: Row(
                                children: [
                                  Text('entry'),
                                  SizedBox(width: deviceWidth * .04),
                                  Chip(
                                      label: Text(
                                          (snap.data as Map)['entry_date']))
                                ],
                              ),
                            )),
                            Expanded(
                                child: ListTile(
                                    title: Row(
                              children: [
                                Text('release'),
                                SizedBox(width: deviceWidth * .04),
                                Chip(
                                    label: Text(
                                        (snap.data as Map)['releasing_date']))
                              ],
                            ))),
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('Parole'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('from'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                      label: Text(
                                          (snap.data as Map)['starting_date'])),
                                ),
                                Text('to'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                    label: Text(
                                        (snap.data as Map)['rejoining_date']),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Transfer'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(255, 255, 255, .3)),
                                ),
                              ),
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
                          child: Text('No visiters...'),
                        )
                      ],
                    ),
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
