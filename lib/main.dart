// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/FootNote.dart';
import 'package:fsd_makueni_mobile_app/Pages/Login.dart';
import 'package:fsd_makueni_mobile_app/Pages/MapPage.dart';
import 'package:fsd_makueni_mobile_app/Pages/ValuationForm.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = const FlutterSecureStorage();
  bool servicestatus = false;
  late LocationPermission permission;
  bool haspermission = false;

  promptUserForLocation() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        storage.write(key: 'haspermission', value: "true");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Location is required! You will be logged out. Please turn on your location"),
      ));
    }
  }

  @override
  void initState() {
    promptUserForLocation();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makueni LIMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(26, 114, 186, 1),
                  Color.fromRGBO(49, 161, 254, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              padding: const EdgeInsets.fromLTRB(0, 50, 24, 0),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(48, 24, 48, 0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200, // Set the desired width
                          ),
                        ),
                        const Text(
                          'MLIMS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Mapping App',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    )),
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft, child: FootNote())
                ],
              ),
            ),
            Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.yellow, size: 100),
            )
          ],
        ),
      ),
    );
  }
}
