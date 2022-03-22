import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prisonbook/models/db_helper.dart';
// import 'package:prisonbook/employee_screens/home_page.dart';
import 'package:prisonbook/screens/employee_home_page.dart';
import 'package:prisonbook/screens/officer_home_page.dart';
import 'package:provider/provider.dart';
// import 'package:prisonbook/screens/home_page.dart';
// import 'package:prisonbook/screens/main_prisoner_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String routeName = 'login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  var isLoading = false;

  void onSubmit(BuildContext context, String username, String password) {
    setState(() {
      isLoading = true;
    });
    Provider.of<DBHelper>(context, listen: false)
        .loginFn(username, password)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      print('!!!!' + value.toString());
      if (value == 'error') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Some error occured '),
                content: Text('please try again later'),
              );
            });
      } else if (value == 'wrong') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Some error occured '),
                content: Text('please check credentials'),
              );
            });
      } else if (value == 'officer') {
        Navigator.of(context).pushNamed(OfficerHomePage.routeName);
      } else {
        Navigator.of(context).pushNamed(EmployeeHomePage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/cop_badge.webp',
                  height: 170,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 40,
                  width: deviceWidth * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(255, 255, 255, .2)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    child: TextFormField(
                      controller: usernameController,
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 40,
                  width: deviceWidth * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(255, 255, 255, .2)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        Feedback.forTap(context);
                        HapticFeedback.heavyImpact();
                        onSubmit(context, usernameController.text,
                            passwordController.text);
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        height: 50,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(255, 255, 255, .2)),
                        child: Center(
                          child: Text('Login'),
                        ),
                      ),
                    ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        )),
      ),
    );
  }
}
