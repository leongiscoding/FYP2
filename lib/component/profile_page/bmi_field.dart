import 'package:flutter/material.dart';

class BMIField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;

  const BMIField({
    required this.labelText,
    required this.controller,
    required this.hintText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const  OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
