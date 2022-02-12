import 'package:flutter/material.dart';

class PrisonerViewDrawer extends StatelessWidget {
  const PrisonerViewDrawer({Key? key}) : super(key: key);

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
            title: Text('Prisoner Health Status'),
            trailing: Icon(Icons.health_and_safety),
          ),
          Divider(),
          ListTile(
            title: Text('Report Malicious Activity'),
            trailing: Icon(Icons.report),
          ),
          Divider(),
          ListTile(
            title: Text('Edit Prisoner Profile'),
            trailing: Icon(Icons.edit),
          ),
          Divider(),
        ],
      ),
    );
  }
}
