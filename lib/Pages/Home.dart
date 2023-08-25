import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fsd_makueni_mobile_app/Components/UserContainer.dart';
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
  String total = '';
  String markets = '';
  String subcounties = '';
  String wards = '';
  dynamic data;
  String username = '';

  final storage = const FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get makueniSubcounties => [
        'Kibwezi East',
        'Kibwezi West',
        'Kilome',
        'Makueni',
        'Mbooni East',
        'Mbooni West',
      ];

  @override
  void initState() {
    getStats();

    fetchUser();
    super.initState();
  }

  fetchUser() async {
    var token = await storage.read(key: "mljwt");
    var decoded = parseJwt(token.toString());

    setState(() {
      username = decoded["Name"];
    });
  }

  getStats() async {
    
      try {
        var id = await storage.read(key: "NationalID");

        // Prefill Form
        try {
          final response = await get(
            Uri.parse("${getUrl()}valuation/topstats"),
          );

          var data = await json.decode(response.body);
          print("stats data is $data");

          setState(() {
            total = data["Allplots"];
            markets = data["Markets"];
            wards = data["Wards"];
            subcounties = data["Subcounties"];
          });
        } catch (e) {
          print(e);
        }
      } catch (e) {}
    
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _scaffoldKey,
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
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: _openDrawer,
                        child: Image.asset(
                          'assets/images/menuicon.png', // Replace with your image asset
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    UserContainer(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            color: Color.fromARGB(255, 26, 114, 186),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        username,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 42, 45, 48),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: "Mapped Plots"),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: markets, name: "Markets"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: wards, name: "Wards"),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child:
                              BlueBox(total: subcounties, name: "Sub Counties"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SubCounties',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 26, 114, 186),
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 10,
                                  getTitlesWidget: (value, meta) {
                                    return const Text(
                                      'Makueni',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                )),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 10,
                                      getTitlesWidget: (value, _) {
                                        return const Text(
                                          'Makueni',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              gridData: FlGridData(show: true),
                              minX: 0,
                              maxX:
                                  6, // Adjust this value based on the number of data points
                              minY: 0,
                              maxY: 6,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 3),
                                    const FlSpot(1, 1),
                                    const FlSpot(2, 4),
                                    const FlSpot(3, 2),
                                    const FlSpot(4, 5),
                                    const FlSpot(5, 1),
                                    const FlSpot(6, 3),
                                  ],
                                  isCurved: true,
                                  color: Colors.blue,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Wards',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 26, 114, 186),
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 10,
                                  getTitlesWidget: (value, meta) {
                                    return const Text(
                                      'Makueni',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                )),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 10,
                                      getTitlesWidget: (value, _) {
                                        return const Text(
                                          'Makueni',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              gridData: FlGridData(show: true),
                              minX: 0,
                              maxX:
                                  6, // Adjust this value based on the number of data points
                              minY: 0,
                              maxY: 6,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 3),
                                    const FlSpot(1, 1),
                                    const FlSpot(2, 4),
                                    const FlSpot(3, 2),
                                    const FlSpot(4, 5),
                                    const FlSpot(5, 1),
                                    const FlSpot(6, 3),
                                  ],
                                  isCurved: true,
                                  color: Colors.blue,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: YellowButton(
                  label: "Start Mapping",
                  onButtonPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const MapPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MakueniSubcountyListWidget extends StatelessWidget {
  const MakueniSubcountyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> makueniSubcounties = [
      'KEast',
    ];

    return Column(
      children: [
        for (var subcounty in makueniSubcounties)
          Text(
            subcounty,
            style: const TextStyle(
              fontSize: 10,
              color: Color.fromARGB(255, 26, 114, 186),
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
