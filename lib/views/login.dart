import 'package:flutter/material.dart';
import 'package:toto_android/controller/controller.dart';
import '../model/colors.dart';
import '../model/globals.dart';
import 'signup.dart';
import '../model/textstyles.dart';
import '../controller/drawers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: TotoDrawers.regularDrawer(context, Globals.username),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      controller: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      controller: passwordController,
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
                            const SnackBar(
                              content: Text('To be implemented'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TotoController.buildAccessButtonLogIn(context, 'Continue', usernameController, passwordController),
            ],
          ),
        ));
  }
}
