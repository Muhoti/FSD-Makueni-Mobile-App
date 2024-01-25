// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/ChangePasswordDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/FootNote.dart';
import 'package:fsd_makueni_mobile_app/Components/MyMap.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:fsd_makueni_mobile_app/Pages/Login.dart';
import 'package:fsd_makueni_mobile_app/Pages/MappedData.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isNotHovered = true;
  TextStyle style = const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(2255, 26, 114, 186),
            Color.fromARGB(255, 26, 114, 186),
          ],
        )),
        child: Column(
          children: [
            Flexible(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: const EdgeInsets.all(0),
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 49, 162, 255)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                        )),
                        const Text(
                          'MLIMS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Home()));
                            },
                            child: MouseRegion(
                              onEnter: (_) =>
                                  setState(() => _isNotHovered = true),
                              onExit: (_) =>
                                  setState(() => _isNotHovered = false),
                              child: Container(
                                padding: _isNotHovered
                                    ? const EdgeInsets.all(0)
                                    : const EdgeInsets.all(16),
                                color: _isNotHovered
                                    ? Colors.transparent
                                    : Colors.blue.withOpacity(0.8),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.home,
                                        color: Colors.white), // Home Icon
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'Home',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MappedData()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.map,
                                    color: Colors.white), // Home Icon
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Map',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    const ChangePasswordDialog(), // Create an instance of the dialog
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.vpn_key,
                                    color: Colors.white), // Home Icon
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: GestureDetector(
                            onTap: () {
                              const store = FlutterSecureStorage();
                              store.deleteAll();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Login()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.home,
                                    color: Colors.white), // Home Icon
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Align(alignment: Alignment.bottomLeft, child: FootNote())
          ],
        ),
      ),
    );
  }
}
