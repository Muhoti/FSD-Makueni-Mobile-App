import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makueni Lims',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Map"),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const Home()))
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 0, 135, 61),
        ),
        floatingActionButton: RawMaterialButton(onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
        }),
      ),
    );
  }
}
