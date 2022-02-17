import 'package:flutter/material.dart';

import 'package:prisonbook/screens/add_prisoner_screen.dart';

import 'package:prisonbook/widgets/prisoner_view_drawer.dart';
import 'package:prisonbook/widgets/prisoner_view_sliver_appbar.dart';

class MainPrisonerView extends StatelessWidget {
  const MainPrisonerView({Key? key}) : super(key: key);

  static const String routeName = 'main prisoner view';

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
                        child: Text('male'),
                        value: 'male',
                      ),
                      DropdownMenuItem(
                        child: Text('female'),
                        value: 'female',
                      )
                    ],
                    onChanged: (val) {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('date')),
                    IconButton(onPressed: () {}, icon: Icon(Icons.done)),
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
      body: CustomScrollView(slivers: [
        SliverAppBar(
          actions: [
            IconButton(
                onPressed: () {
                  healthDialogCard(context);
                },
                icon: Icon(Icons.health_and_safety)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPrisonerScreen.routeName);
                },
                icon: Icon(Icons.edit))
          ],
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: PrisonerViewSliverAppbar(),
        ),
        SliverFillRemaining(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Crime'),
                ),
                ListTile(title: Text('Section')),
                Row(
                  children: [
                    Expanded(child: ListTile(title: Text('entry'))),
                    Expanded(child: ListTile(title: Text('release'))),
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
                      child: Text('address'),
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
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(255, 255, 255, .3)),
                          ),
                        ),
                        Text('to'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(255, 255, 255, .3)),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
      ]),
    );
  }
}
