import 'package:flutter/material.dart';
import 'package:prisonbook/widgets/add_prisoner_sliver_appbar.dart';

class AddPrisonerScreen extends StatefulWidget {
  const AddPrisonerScreen({Key? key}) : super(key: key);

  static const String routeName = 'add prisoner page';

  @override
  State<AddPrisonerScreen> createState() => _AddPrisonerScreenState();
}

class _AddPrisonerScreenState extends State<AddPrisonerScreen> {
  Widget greyContainerBuilder(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black.withOpacity(.1),
        padding: EdgeInsets.all(5),
        child: child,
      ),
    );
  }

  var _gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done))],
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: AddPrisonerSliverAppBar(),
          ),
          SliverFillRemaining(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      greyContainerBuilder(
                        TextFormField(
                          decoration: InputDecoration(label: Text('name')),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 70,
                            color: Colors.black.withOpacity(.1),
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              decoration: InputDecoration(label: Text('age')),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(.1),
                            padding: EdgeInsets.all(5),
                            child: DropdownButton(
                                hint:
                                    Text(_gender == null ? 'gender' : _gender),
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
                                onChanged: (val) {
                                  setState(() {
                                    _gender = val.toString();
                                  });
                                }),
                          ),
                        ],
                      ),
                      greyContainerBuilder(
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(label: Text('address')),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: greyContainerBuilder(
                              TextFormField(
                                decoration:
                                    InputDecoration(label: Text('crime')),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 70,
                              color: Colors.black.withOpacity(.1),
                              padding: EdgeInsets.all(5),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text('section')),
                              ),
                            ),
                          ),
                        ],
                      ),
                      greyContainerBuilder(
                        TextFormField(
                          decoration: InputDecoration(label: Text('cell.no')),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: Text('entry date')),
                          ElevatedButton(
                              onPressed: () {}, child: Text('release date'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
