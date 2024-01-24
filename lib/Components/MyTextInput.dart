// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  final String title;
  final String value;
  final int lines;
  final TextInputType type;
  final Function(String) onSubmit;

  const MyTextInput(
      {super.key,
      required this.title,
      required this.lines,
      required this.value,
      required this.type,
      required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  TextEditingController _controller = TextEditingController();
  String _value = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.value;
    });
    _controller = TextEditingController(text: _value);
  }

  @override
  void didUpdateWidget(covariant MyTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != "") {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          hintColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            widget.onSubmit(value);
          },
          keyboardType: widget.type,
          controller: _controller,
          maxLines: widget.lines,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          obscureText: widget.type == TextInputType.visiblePassword,
          enableSuggestions: true,
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintStyle: const TextStyle(color: Colors.white54),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1.0),
            ),
            focusColor: Colors.yellow,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 2.0),
            ),
            filled: false,
            label: Text(
              widget.title,
              style: const TextStyle(color: Colors.white60),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ),
    );
  }
}
