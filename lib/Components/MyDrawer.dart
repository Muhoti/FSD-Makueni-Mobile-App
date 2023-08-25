import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyMap.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:fsd_makueni_mobile_app/Pages/Login.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

    return Drawer(
      child: Container(
          //  decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //           'assets/images/bg.png'), // Replace with your image path
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(2255, 26, 114, 186),
              Color.fromARGB(255, 26, 114, 186),
            ],
          )),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Center(child: Image.asset('assets/images/logo.png'))),
              ListTile(
                title: const Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const Home()));
                },
              ),
              ListTile(
                title: const Text(
                  'Map',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MyMap(
                                lat: 1.2921,
                                lon: 36.8219,
                              )));
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: style,
                ),
                onTap: () {
                  const store = FlutterSecureStorage();
                  store.deleteAll();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const Login()));
                },
              ),
            ],
          )),
    );
  }
}
