import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  style: TotoTextStyles.titleLarge(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 30.0, 0, 0),
              child: Title(
                color: TotoColors.textColor,
                child: Text(
                  'Sign In',
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
              padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      'Forgot Password?',
                      style: TotoTextStyles.titleSmall(context),
                    ),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('To be implemented'),
                      ),
                    ),
                  ),
                  InkWell(
                      child: Text(
                        'Sign Up',
                        style: TotoTextStyles.titleSmall(context),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()))
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: MaterialButton(
                onPressed: () => null,
                child: Text(
                  'Continue',
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
