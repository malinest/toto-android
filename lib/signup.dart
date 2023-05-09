import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/login.dart';
import 'package:toto_android/textstyles.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 30.0, 0, 0),
              child: Title(
                color: TotoColors.textColor,
                child: Text(
                  'Sign Up',
                  style: TotoTextStyles.titleMedium(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 20.0, 0, 0),
              child: Title(
                color: TotoColors.textColor,
                child: Text(
                  'Hi there! Welcome to Toto.',
                  style: TotoTextStyles.bodyLarge(context),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 0),
              child: InkWell(
                child: Text(
                  'I already have an account',
                  style: TotoTextStyles.titleSmall(context),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: MaterialButton(
                onPressed: () => null,
                child: Text(
                  'Create an account',
                  style: TotoTextStyles.labelLarge(context),
                ),
                color: TotoColors.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
