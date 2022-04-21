import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class OfficersListScreen extends StatelessWidget {
  const OfficersListScreen({Key? key}) : super(key: key);

  static const String routeName = 'officers list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Officers'),
      ),
      body: FutureBuilder(
          future: Provider.of<DBHelper>(context).fetchAndSetOfficersList(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(),
                          title: Text((snap.data as dynamic)[index]['name']),
                          subtitle:
                              Text((snap.data as dynamic)[index]['position']),
                        ),
                        Divider()
                      ],
                    );
                  });
            } else {
              return Center(
                child: Text('Something went wrong'),
              );
            }
          }),
    );
  }
}
