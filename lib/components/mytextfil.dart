import 'package:flutter/material.dart';

class DefaultAppTextField extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextCapitalization? textCapitalization;
  final FocusNode? focus;
  final TextInputType? textInputType;
  final bool? autofocus;
  const DefaultAppTextField({
    Key? key,
    required this.hintText,
    this.onTap,
    this.controller,
    this.focus,
    this.textCapitalization,
    this.textInputType,
    this.onChanged,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        keyboardType: textInputType ?? TextInputType.text,
        onChanged: onChanged,
        cursorWidth: 1.5,
        style: const TextStyle(fontFamily: 'Helvetica-Light'),
        autofocus: autofocus ?? false,
        onTap: onTap,
        cursorColor: Colors.black,
        focusNode: focus,
        controller: controller,
        decoration: inputdectoration(hintText),
      ),
    );
  }
}



InputDecoration inputdectoration(String? hintText) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20, 13, 12, 11),
      hintText: hintText,
  
      labelStyle: const TextStyle(color: Colors.indigo),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Color(0xffE3E5E5))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1.5, color: Colors.indigo)));
}