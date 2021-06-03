import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final bool obscureText;
  final TextEditingController controller;

  const InputField({
    this.labelText,
    this.onChanged,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.obscureText = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}