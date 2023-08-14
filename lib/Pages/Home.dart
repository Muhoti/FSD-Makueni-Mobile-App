import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fsd_makueni_mobile_app/Components/MLDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/Stat.dart';
import 'package:fsd_makueni_mobile_app/Pages/Map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String total = '';
  String markets = '';
  String subcounties = '';
  String wards = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Makueni Lims',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Home"),
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
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Map()));
          },
          elevation: 5.0,
          fillColor: const Color.fromARGB(255, 0, 135, 61),
          padding: const EdgeInsets.all(10),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_location,
            size: 24,
            color: Colors.white,
          ),
        ),
        drawer: const Drawer(child: MLDrawer()),
        body: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      "$subcounties Subcounty",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Total",
                          image: 'assets/images/stat1.png',
                          value: total,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Markets",
                          image: 'assets/images/stat2.png',
                          value: markets,
                        )),
                    
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Wards",
                          image: 'assets/images/stat3.png',
                          value: wards,
                        )),
                  ],
                )),
                 Padding(
                  padding: EdgeInsets.fromLTRB(24, 5, 24, 0),
                  child: Column(
                    children: [
                    ],
                  ),
                  )
          ],
        ),
      ),
    );
  }
}
