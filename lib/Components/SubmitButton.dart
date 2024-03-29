// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final onButtonPressed;
  const SubmitButton({super.key, required this.label, this.onButtonPressed});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12)),
          onPressed: widget.onButtonPressed,
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          )),
    );
  }
}
