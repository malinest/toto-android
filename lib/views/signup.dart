import 'package:flutter/material.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/views/login.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/controller/controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                TotoController.getHeader(context, 'Log in', const LoginPage()),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    controller: usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    controller: confirmPasswordController,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            TotoController.buildAccessButtonSignUp(
                context, 'Create an account', usernameController, emailController, passwordController, confirmPasswordController),
          ],
        ),
      ),
    );
  }
}
