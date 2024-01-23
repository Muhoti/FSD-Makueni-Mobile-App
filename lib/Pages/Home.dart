// ignore_for_file: file_names, empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/UserContainer.dart';
import 'package:fsd_makueni_mobile_app/Components/UserProfileDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';
import 'package:fsd_makueni_mobile_app/Pages/MapPage.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int total = 0;
  int markets = 0;
  dynamic data;
  String username = '';
  String id = '';
  List<dynamic> marketList = [];

  List<dynamic> plotList = [];

  List<FlSpot> marketData = [];
  List<FlSpot> plotData = [];

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  fetchUser() async {
    var token = await storage.read(key: "mljwt");
    var decoded = parseJwt(token.toString());

    setState(() {
      username = decoded["Name"];
      id = decoded["UserID"];
      storage.write(key: "UserName", value: username);
      storage.write(key: "id", value: decoded["UserID"]);
    });

    getStats(id);
    loadChartData(username);
  }

  Future<void> loadChartData(String username) async {
    try {
      try {
        final response = await get(
          Uri.parse("${getUrl()}valuation/stats/$username"),
        );

        var data = await json.decode(response.body);

        setState(() {
          marketList = (data["market"]);
          plotList = data["plots"];
        });

        // Populate market data
        marketData = marketList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final count = double.parse(entry.value["count"]!);

          return FlSpot(index, count);
        }).toList();

        // Populate plot data
        plotData = plotList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final count = double.parse(entry.value["count"]!);

          return FlSpot(index, count);
        }).toList();
      } catch (e) {}
    } catch (e) {}
  }

  getStats(String id) async {
    try {
      try {
        final response = await get(
          Uri.parse("${getUrl()}valuation/topstats/$id"),
        );
        var data = await json.decode(response.body);
        setState(() {
          total = data["Allplots"];
          markets = data["Markets"];
        });
      } catch (e) {}
    } catch (e) {}
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openUserProfileDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          const UserProfileDialog(), // Create an instance of the dialog
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      floatingActionButton: YellowButton(
          label: 'NEW',
          onButtonPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const MapPage()))),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(26, 114, 186, 1),
            Color.fromRGBO(49, 161, 254, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        constraints: const BoxConstraints.tightForFinite(),
        padding: const EdgeInsets.fromLTRB(24, 44, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: GestureDetector(
                  onTap: _openDrawer,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: BlueBox(total: total, name: "Today"),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: BlueBox(total: markets, name: "Total"),
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
