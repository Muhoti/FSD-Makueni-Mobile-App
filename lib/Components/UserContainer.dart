// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UserContainer extends StatelessWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 238, 240),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/user.png',
              height: 40, // Adjust the image size as needed
            ),
          ],
        ),
      ),
    );
  }
}
