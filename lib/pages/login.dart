// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/components/constants.dart';
import 'package:chat_app/components/mybtn.dart';
import 'package:chat_app/components/mytextfil.dart';
import 'package:chat_app/components/textspans.dart';
import 'package:chat_app/service/auths.dart';
import 'package:chat_app/pages/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = 'test2@gmail.com';
  String password = '123456';

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text('LOGIN'),
              ),
              DefaultAppTextField(
                hintText: 'email',
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              DefaultAppTextField(
                  hintText: 'password',
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 39),
                child: AppButton(
                  onTap: () {
                    _authService.signinwEmailandPass(context, email, password);
                  },
                  name: 'Login',
                ),
              ),
              AuthTextSpan(
                quiz: 'Register here:',
                ans: 'Register',
                onTap: () {
                  goToPage(context, RegPage());
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
