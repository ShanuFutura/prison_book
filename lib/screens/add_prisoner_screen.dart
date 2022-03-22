import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:prisonbook/screens/employee_home_page.dart';
// import 'package:prisonbook/widgets/add_prisoner_sliver_appbar.dart';
import 'package:provider/provider.dart';

class AddPrisonerScreen extends StatefulWidget {
  const AddPrisonerScreen({Key? key}) : super(key: key);

  static const String routeName = 'add prisoner page';

  @override
  State<AddPrisonerScreen> createState() => _AddPrisonerScreenState();
}

final fkey = GlobalKey<FormState>();
var isAdded;
bool isLoading = false;
var name = '';
var age;
var gender;
var address = '';
var crime = '';
var section = '';
var cell_no = '';
var entryDate;
var releaseDate;
var profileImage;

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

  Future<void> _selectEntryDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(
        const Duration(days: 10950),
      ),
    );
    if (picked != null && picked != entryDate)
      setState(() {
        entryDate = picked;
        print(entryDate.toIso8601String());
      });
  }

  Future<void> _selectReleaseDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(
        const Duration(days: 10950),
      ),
    );
    if (picked != null && picked != releaseDate)
      setState(() {
        releaseDate = picked;
        print(releaseDate.toIso8601String());
      });
  }

  trySave() async {
    setState(() {
      isLoading = true;
    });
    if (fkey.currentState!.validate()) {
      if (profileImage != null) {
        fkey.currentState!.save();
        isAdded = await Provider.of<DBHelper>(context, listen: false)
            .addPrisoner(
                name: name,
                crime: crime,
                entry_date: entryDate,
                releasing_date: releaseDate,
                age: age,
                address: address,
                cell_no: cell_no,
                gender: gender,
                imageFile: profileImage,
                section: section);
      } else {
        Fluttertoast.showToast(msg: 'please select image');
        isAdded = false;
      }
    }
    if (isAdded) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'successfully added');
      Navigator.of(context).pushReplacementNamed(EmployeeHomePage.routeName);
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'couldnt add');
    }
  }

  getPick() async {
    profileImage =
        await Provider.of<DBHelper>(context, listen: false).pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: trySave,
        child: Icon(Icons.save),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.done))
                  ],
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 90,
                                  backgroundImage: profileImage != null
                                      ? FileImage(profileImage)
                                      : AssetImage('assets/avatar.png')
                                          as ImageProvider,
                                ),
                                GestureDetector(
                                  onTap: getPick,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Form(
                    key: fkey,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            greyContainerBuilder(
                              TextFormField(
                                decoration:
                                    InputDecoration(label: Text('name')),
                                validator: (v) {
                                  if (v!.trim().isEmpty) {
                                    return 'name cannot be empty';
                                  }
                                },
                                onSaved: (v) {
                                  name = v!;
                                },
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
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        InputDecoration(label: Text('age')),
                                    validator: (v) {
                                      if (v!.trim().isEmpty) {
                                        return 'age cannot be empty';
                                      }
                                      if (int.parse(v) > 120) {
                                        return 'enter a valid age';
                                      }
                                    },
                                    onSaved: (v) {
                                      age = v;
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(.1),
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton(
                                      hint: Text(
                                          gender == null ? 'gender' : gender),
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
                                          gender = val.toString();
                                        });
                                      }),
                                ),
                              ],
                            ),
                            greyContainerBuilder(
                              TextFormField(
                                maxLines: 5,
                                decoration:
                                    InputDecoration(label: Text('address')),
                                validator: (v) {
                                  if (v!.trim().isEmpty) {
                                    return 'address cannot be empty';
                                  }
                                },
                                onSaved: (v) {
                                  address = v!;
                                },
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
                                      validator: (v) {
                                        if (v!.trim().isEmpty) {
                                          return 'Crime cannot be empty';
                                        }
                                      },
                                      onSaved: (v) {
                                        crime = v!;
                                      },
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          label: Text('section')),
                                      validator: (v) {
                                        if (v!.trim().isEmpty) {
                                          return 'enter section';
                                        }
                                      },
                                      onSaved: (v) {
                                        section = v!;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            greyContainerBuilder(
                              TextFormField(
                                decoration:
                                    InputDecoration(label: Text('cell.no')),
                                keyboardType: TextInputType.number,
                                validator: (v) {
                                  if (v!.trim().isEmpty) {
                                    return 'cell number cannot be empty';
                                  }
                                },
                                onSaved: (v) {
                                  cell_no = v!;
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectEntryDate(context);
                                  },
                                  child: Chip(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(entryDate == null
                                          ? 'entry date'
                                          : DateFormat('dd/MM/yyyy')
                                              .format(entryDate)),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectReleaseDate(context);
                                  },
                                  child: Chip(
                                    label: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        releaseDate == null
                                            ? 'release date'
                                            : DateFormat('dd/MM/yyyy')
                                                .format(releaseDate),
                                      ),
                                    ),
                                  ),
                                ),
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
