import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final TextEditingController controller;
   EmailField({
     required this.controller,
     super.key
   });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Email",
        hintText: "Ex: yourname@example.com",
      ),
    );
  }
}

