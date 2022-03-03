import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class ParolList extends StatelessWidget {
  const ParolList({Key? key}) : super(key: key);

  static const String routeName = 'parol list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming parols'),
      ),
      body: FutureBuilder(
        future: Provider.of<DBHelper>(context).getParolsList(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              Provider.of<DBHelper>(context).urlS +
                                  'images/' +
                                  (snap.data as dynamic)[index]['photo']),
                        ),
                        title: Text((snap.data as dynamic)[index]['name']),
                        subtitle: Row(
                          children: [
                            Chip(
                              label: Text((snap.data as dynamic)[index]
                                  ['starting_date']),
                            ),
                            Text(' to '),
                            Chip(
                              label: Text((snap.data as dynamic)[index]
                                  ['rejoining_date']),
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
