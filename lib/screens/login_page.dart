import 'package:flutter/material.dart';
import 'package:prisonbook/employee_screens/home_page.dart';
// import 'package:prisonbook/screens/home_page.dart';
// import 'package:prisonbook/screens/main_prisoner_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String routeName = 'login page';

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
                    child: TextFormField(),
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
                    child: TextFormField(),
                  )),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(HomePage.routeName);
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
