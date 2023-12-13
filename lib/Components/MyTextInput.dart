// ignore_for_file: must_be_immutable, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  final String title;
  final String value;
  final int lines;
  final TextInputType type;
  final Function(String) onSubmit;

  MyTextInput({
    Key? key,
    required this.title,
    required this.lines,
    required this.value,
    required this.type,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant MyTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.value.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: TextField(
        onChanged: (value) {
          _controller.value = TextEditingValue(
            text: value,
            selection: TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          );
          widget.onSubmit(value);
        },
        keyboardType: widget.type,
        controller: _controller,
        maxLines: widget.lines,
        obscureText:
            widget.type == TextInputType.visiblePassword ? true : false,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(color: Color.fromARGB(255, 42, 44, 46)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: false,
          label: Text(
            widget.title,
            style: const TextStyle(color: Color.fromARGB(255, 26, 114, 186)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
