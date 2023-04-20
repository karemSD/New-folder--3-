import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  const MyTextFiled({
    super.key,
    required this.hinText,
    required this.inputType,
    required this.prefixIcon,
    this.isDense = false,
    required this.obscureText,
    required this.controller,
  });
  final TextEditingController controller;
  final String? hinText;
  final TextInputType? inputType;
  final Icon? prefixIcon;
  final bool? isDense;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          prefixIcon: prefixIcon,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: hinText,
          fillColor: Colors.grey.shade200,
          filled: true,
          isDense: isDense,
        ),
      ),
    );
  }
}
