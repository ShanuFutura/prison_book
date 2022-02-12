import 'package:flutter/material.dart';
import 'package:prisonbook/screens/add_prisoner_screen.dart';

class PrisonerViewDrawer extends StatelessWidget {
  final Function maliciousFn;
  final Function prisonerHealthFn;

  PrisonerViewDrawer(
      {required this.maliciousFn, required this.prisonerHealthFn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 300,
          ),
          Divider(),
          ListTile(
            onTap: () {
              prisonerHealthFn(context);
            },
            title: Text('Prisoner Health Status'),
            trailing: Icon(Icons.health_and_safety),
          ),
          Divider(),
          ListTile(
            onTap: () {
              maliciousFn(context);
            },
            title: Text('Report Malicious Activity'),
            trailing: Icon(Icons.report),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(AddPrisonerScreen.routeName);
            },
            title: Text('Edit Prisoner Profile'),
            trailing: Icon(Icons.edit),
          ),
          Divider(),
        ],
      ),
    );
  }
}
