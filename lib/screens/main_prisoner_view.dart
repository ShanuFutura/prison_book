import 'package:flutter/material.dart';
import 'package:prisonbook/widgets/prisoner_view_sliver_appbar.dart';

class MainPrisonerView extends StatelessWidget {
  const MainPrisonerView({Key? key}) : super(key: key);

  static const String routeName = 'main prisoner view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return Dialog(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
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
        },
        child: Icon(Icons.report),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
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
                Text('crime'),
                Text('section'),
                Row(
                  children: [Text('entry      '), Text('release')],
                ),
                Text('address'),
                Divider(),
                Text('parol-      start,   end'),
                Text('transfer      date'),
                Text('visitors'),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
