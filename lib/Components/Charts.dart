// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fsd_makueni_mobile_app/Components/Home.dart';
import 'package:fsd_makueni_mobile_app/Components/FootNote.dart';
import 'package:fsd_makueni_mobile_app/Components/MLDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/Stat.dart';
import 'package:fsd_makueni_mobile_app/Components/TextLarge.dart';
import 'package:fsd_makueni_mobile_app/Components/TextMedium.dart';
import 'package:fsd_makueni_mobile_app/Components/barchart_model.dart';
import 'package:fsd_makueni_mobile_app/Pages/Login.dart';
import 'package:fsd_makueni_mobile_app/Pages/Map.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  String total = '';
  String markets = '';
  String subcounties = '';
  String wards = '';
  final List<BarChartModel> data = [
    BarChartModel(
        year: '2014',
        financial: 250,
        color: ColorUtil.fromDartColor(Colors.blue)),
    BarChartModel(
        year: '2015',
        financial: 250,
        color: ColorUtil.fromDartColor(Colors.red)),
    BarChartModel(
        year: '2016',
        financial: 250,
        color: ColorUtil.fromDartColor(Colors.green)),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyChart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
            icon: Image.asset(
              'assets/images/menuicon.png',
              width: 24,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                const Drawer();
              },
              icon: Image.asset(
                'assets/images/user.png',
                width: 50, // Set the desired width
              ),
              //icon: const Icon(FontAwesome.user_circle)
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Handle drawer item 1 tap
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Handle drawer item 2 tap
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              
              Column(
                children: [
                  Row(
                    children: const [
                      Expanded(child: BlueBox(name: 'name', total: '2')),
                      Expanded(child: BlueBox(name: 'name', total: '2')),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(child: BlueBox(name: 'name', total: '2')),
                      Expanded(child: BlueBox(name: 'name', total: '2')),
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
