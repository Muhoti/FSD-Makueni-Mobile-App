import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Components/MyMap.dart';
import 'package:fsd_makueni_mobile_app/Components/PlotDetailsDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var long = 36.2, lat = -2.3;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showPlotDetailsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const PlotDetails();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapPage',
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
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: MyMap(
                    lat: lat,
                    lon: long,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: YellowButton(
                  label: "Capture Point",
                  onButtonPressed: _showPlotDetailsDialog,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
