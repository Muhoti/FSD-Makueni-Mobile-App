import 'dart:async';

import 'package:flutter/material.dart';

class MySelectInput extends StatefulWidget {
  final String value;
  final List<String> entries;
  final Function(dynamic) onSubmit;

  const MySelectInput(
      {super.key,
      required this.onSubmit,
      required this.entries,
      required this.value});

  @override
  State<StatefulWidget> createState() => _MySelectInputState();
}

class _MySelectInputState extends State<MySelectInput> {
  List<DropdownMenuItem<String>> menuItems = [];
  String selected = "";

  @override
  void initState() {
    if (widget.entries.isNotEmpty) {
      setState(() {
        if (widget.entries.contains(widget.value)) {
          selected = widget.value;
        } else
          selected = widget.entries[0];
        menuItems = widget.entries
            .map((item) => DropdownMenuItem(child: Text(item), value: item))
            .toList();
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MySelectInput oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.entries.length > 0) {
      setState(() {
        if (widget.entries.contains(widget.value)) {
          selected = widget.value;
        } else
          selected = widget.entries[0];
        menuItems = widget.entries
            .map((item) => DropdownMenuItem(child: Text(item), value: item))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: DropdownButtonFormField(
            items: menuItems,
            value: selected,
            onChanged: widget.onSubmit,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                floatingLabelBehavior: FloatingLabelBehavior.auto),
          )),
    );
  }
}
