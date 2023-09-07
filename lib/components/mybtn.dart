import 'package:chat_app/components/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String? name;

  const AppButton({
    Key? key,
    this.onTap,
    this.color,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: buttonShape,
              foregroundColor: const Color(0xFFF2F8FB),
              backgroundColor: color ?? primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16.5)),
          onPressed: onTap,
          child: Text(
            name ?? 'Continue',
            style: buttonTextStyle,
          )),
    );
  }
}

OutlinedBorder buttonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
);

TextStyle buttonTextStyle = const TextStyle(
    fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w700);

Widget greyAppButton = const AppButton(
  color: Color(0xffE3E5E5),
);
