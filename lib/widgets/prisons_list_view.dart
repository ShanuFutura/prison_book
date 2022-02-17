import 'package:flutter/material.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';

class PrisonsListView extends StatelessWidget {
  const PrisonsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  Navigator.of(context).pushNamed(MainPrisonerView.routeName);
                },
                child: Text('View')),
          );
        });
  }
}
