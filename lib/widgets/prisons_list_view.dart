import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/main_prisoner_view.dart';
import 'package:provider/provider.dart';

class PrisonsListView extends StatelessWidget {
  final isOfficerView;
  PrisonsListView({this.isOfficerView = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<DBHelper>(context).fetchAndSetPrisonersList(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.connectionState == ConnectionState.done) {
            final prisonersList = Provider.of<DBHelper>(context).prisonersList;

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                // physics:BouncingScrollPhysics(),
                itemCount: prisonersList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    title: Text(prisonersList[index]['prisoner_name']),
                    // subtitle: Text('prisoner number'),
                    trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              MainPrisonerView.routeName,
                              arguments: prisonersList[index]['prisoner_id']);
                        },
                        child: Text('View')),
                  );
                });
          } else
            return Center(
              child: Text('No Data Fetched'),
            );
        });
  }
}
