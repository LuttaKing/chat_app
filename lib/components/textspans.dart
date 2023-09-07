import 'package:chat_app/components/constants.dart';
import 'package:flutter/material.dart';

class AuthTextSpan extends StatelessWidget {
  final String quiz;
  final String ans;
  final VoidCallback? onTap;
  const AuthTextSpan({
    Key? key,
    required this.quiz,
    required this.ans, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Text.rich(
        TextSpan(
            text: quiz,
            style: const TextStyle(
                fontFamily: 'Helvetica-Light',
                height: 1.3,
                letterSpacing: 0.3,
                fontSize: 15.5),
            children: [
              TextSpan(
                  text: ' $ans',
                  style: const TextStyle(
                      color: primaryColor,
                      height: 1.3,
                      fontFamily: 'Helvetica-Bold',
                      letterSpacing: 0.3,
                      fontSize: 15.5)),
            ]),
      ),
    );
  }
}
