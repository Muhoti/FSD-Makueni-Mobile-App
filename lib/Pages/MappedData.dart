// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MappedMap.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/MyMap.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:geolocator/geolocator.dart';

class MappedData extends StatefulWidget {
  const MappedData({super.key});

  @override
  State<MappedData> createState() => _MappedDataState();
}

class _MappedDataState extends State<MappedData> {
  final storage = const FlutterSecureStorage();
  bool servicestatus = false;
  late LocationPermission permission;
  bool haspermission = false;
  late Position position;
  var long;
  var lat;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getUserLocation() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        long = position.longitude;
        lat = position.latitude;
      });

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );

      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position position) {
        setState(() {
          long = position.longitude;
          lat = position.latitude;
        });
      });
    } else {
      promptUserForLocation();
    }
  }

  promptUserForLocation() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    }
  }

  @override
  void initState() {
    promptUserForLocation();
    getUserLocation();
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MappedData',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: const MyDrawer(),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(26, 114, 186, 1),
              Color.fromRGBO(49, 161, 254, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: _openDrawer,
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "Mapped Data",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Home()));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: long != null && lat != null
                      ? const MappedMap()
                      : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
