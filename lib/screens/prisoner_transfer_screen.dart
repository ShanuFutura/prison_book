import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/widgets/transfer_prisoner_listtile.dart';
import 'package:provider/provider.dart';

class PrisonerTransferScreen extends StatelessWidget {
  const PrisonerTransferScreen({Key? key}) : super(key: key);

  static const String routeName = 'prisoner transfer list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: Provider.of<DBHelper>(context).getTransferList(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              bool isExpanded = false;
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        TransferPrisonerListTile(index: index, snap: snap),
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
