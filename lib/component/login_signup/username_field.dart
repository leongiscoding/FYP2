import 'package:flutter/material.dart';

class UsernameField extends StatefulWidget {
  final TextEditingController controller;
  const UsernameField({
    required this.controller,
    super.key
  });

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Username",
        hintText: "Ex: Bob",
      ),
    );
  }
}
