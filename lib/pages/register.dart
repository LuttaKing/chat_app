// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/components/constants.dart';
import 'package:chat_app/components/mybtn.dart';
import 'package:chat_app/components/mytextfil.dart';
import 'package:chat_app/components/textspans.dart';
import 'package:chat_app/service/auths.dart';
import 'package:chat_app/pages/login.dart';
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  String email = '';
  String password = '';

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
                child: Text('Register'),
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
                    _authService.createAccountwEmailandPass(
                        context, email, password);
                  },
                  name: 'Register',
                ),
              ),
              AuthTextSpan(
                quiz: 'Login here:',
                ans: 'Login',
                onTap: () {
                  goToPage(context, LoginPage());
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
