import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/login.dart';
import 'package:toto_android/textstyles.dart';
import 'package:toto_android/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TotoUtils.getHeader(context, 'Log in', const LoginPage()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0, 0),
                  child: Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'Sign Up',
                      style: TotoTextStyles.titleMedium(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 0, 0),
                  child: Title(
                    color: TotoColors.textColor,
                    child: Text(
                      'Hi there! Welcome to Toto.',
                      style: TotoTextStyles.bodyLarge(context),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
            TotoUtils.buildAccessButton(
                context, 'Create an account', () => null),
          ],
        ),
      ),
    );
  }
}
