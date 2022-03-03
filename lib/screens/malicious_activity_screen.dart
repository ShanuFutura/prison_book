import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class MaliciousActivityListScreen extends StatelessWidget {
  const MaliciousActivityListScreen({Key? key}) : super(key: key);

  static const String routeName = 'Malicious act list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malicious Activities'),
      ),
      body: FutureBuilder(
        future: Provider.of<DBHelper>(context).getMaliciousList(),
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
                        title: Text((snap.data as dynamic)[index]['prisoner']),
                        subtitle: Text((snap.data as dynamic)[index]['name']),
                        trailing: Text((snap.data as dynamic)[index]['date']),
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
