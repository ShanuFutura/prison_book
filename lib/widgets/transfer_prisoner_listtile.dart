import 'package:flutter/material.dart';

class TransferPrisonerListTile extends StatefulWidget {
  TransferPrisonerListTile({
    Key? key,
    required this.index,
    required this.snap,
  }) : super(key: key);
  final int index;
  final dynamic snap;

  @override
  State<TransferPrisonerListTile> createState() =>
      _TransferPrisonerListTileState();
}

class _TransferPrisonerListTileState extends State<TransferPrisonerListTile> {
  @override
  bool isExpanded = false;
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          print(isExpanded);
        });
      },
      // leading: CircleAvatar(),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text((widget.snap.data as dynamic)[widget.index]['name']),
      ),
      trailing:
          Text((widget.snap.data as dynamic)[widget.index]['transfer_date']),
      subtitle: isExpanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Reason: ' +
                      (widget.snap.data as dynamic)[widget.index]
                          ['transfer_reason']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('To ' +
                      (widget.snap.data as dynamic)[widget.index]
                          ['transfered_prison']),
                ),
              ],
            )
          : Container(),
    );
  }
}
