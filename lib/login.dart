import 'package:flutter/material.dart';
import 'package:toto_android/controller.dart';
import 'colors.dart';
import 'signup.dart';
import 'textstyles.dart';
import 'drawers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: TotoDrawers.regularDrawer(context),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TotoController.getHeader(context, 'Sign Up', const SignUpPage()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 20.0, 0, 0),
                  child: Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'Log In',
                      style: TotoTextStyles.titleMedium(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 0, 0),
                  child: Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'Hi there! Welcome back.',
                      style: TotoTextStyles.bodyLarge(context),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Text(
                          'Forgot Password?',
                          style: TotoTextStyles.displaySmall(context),
                        ),
                        onTap: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('To be implemented'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TotoController.buildAccessButton(context, 'Continue', () => null),
          ],
        ));
  }
}
