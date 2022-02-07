import 'package:flutter/material.dart';
import 'package:prisonbook/models/dummyDatas.dart';
import 'package:prisonbook/widgets/employee_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.event)),
          IconButton(onPressed: () {}, icon: Icon(Icons.local_police)),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 200),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: DummyDatas.ListTileList.length,
              itemBuilder: (context, index) {
                return DummyDatas.ListTileList[index];
              }),
        ],
      ),
      drawer: EmployeeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
