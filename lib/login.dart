import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/textstyles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SvgPicture.asset('assets/logo.svg', height: 80),
            ),
            Center(
              child: Title(
                color: TotoColors.textColor,
                child: Text(
                  'Toto',
                  style: TotoTextStyles.bodyLarge(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 30.0, 0, 0),
              child: Title(
                color: TotoColors.textColor,
                child: Text(
                  'Sign In',
                  style: TotoTextStyles.bodyMedium(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
