import 'package:flutter/material.dart';

class NameField extends StatefulWidget {
  final TextEditingController controller;
   NameField({
     required this.controller,
     super.key
   });

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Name",
        hintText: "Type Your Name Here",
      ),
    );
  }
}

