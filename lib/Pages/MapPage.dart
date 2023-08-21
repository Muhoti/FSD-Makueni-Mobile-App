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
