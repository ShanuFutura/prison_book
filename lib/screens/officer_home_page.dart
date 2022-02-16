import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Project Name'),
              background: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/prison_vector.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromRGBO(0, 0, 0, 0),
                          Theme.of(context).canvasColor
                        ])),
                  )
                ],
              ),
            ),
            pinned: true,
            expandedHeight: fullHeight * .27,
            actions: [
              IconButton(
                  onPressed: () {},
                  // => Navigator.of(context)
                  //     .pushNamed(AttendaceScreen.routeName),
                  icon: Icon(Icons.event)),
              IconButton(
                  onPressed: () {},
                  // => Navigator.of(context)
                  //     .pushNamed(OfficersListScreen.routeName),
                  icon: Icon(Icons.local_police)),
            ],
          ),
          SliverFillRemaining(
            child: ListView.builder(
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
                          // Navigator.of(context)
                          //     .pushNamed(MainPrisonerView.routeName);
                        },
                        child: Text('View')),
                  );
                }),
          )
        ],
      ),
    );
  }
}
