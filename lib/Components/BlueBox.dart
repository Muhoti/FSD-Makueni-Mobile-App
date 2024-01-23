// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BlueBox extends StatelessWidget {
  final int total;
  final String name;

  const BlueBox({super.key, required this.total, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 140,
            width: 140,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.yellow,
                  Colors.orange,
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                width: 5.0,
                color: Colors.blue,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    total.toString(),
                    style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w900,
                        fontSize: 36),
                  ),
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
