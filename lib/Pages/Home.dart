import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fsd_makueni_mobile_app/Components/ChangePasswordDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/MyMap.dart';
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

  String total = '';
  String markets = '';
  String subcounties = '';
  String wards = '';
  dynamic data;
  String username = '';

  List<FlSpot> subcountyData = [];
  List<FlSpot> wardData = [];

  final subcountyList = [
    {"SubCounty": "Isiolo", "count": "2"},
    {"SubCounty": "Marakwet", "count": "1"},
    {"SubCounty": "West Pokot", "count": "3"},
    // Add more data as needed...
  ];

  final wardList = [
    {"Ward": "Isiolo", "count": "2"},
    {"Ward": "Marakwet", "count": "1"},
    {"Ward": "Pokot", "count": "3"},
    // Add more data as needed...
  ];

  @override
  void initState() {
    getStats();

    fetchUser();
    loadChartData();
    super.initState();
  }

  void loadChartData() {
    // Populate subcounty data
    subcountyData = subcountyList.asMap().entries.map((entry) {
      final index = entry.key.toDouble() + 1;
      final count = double.parse(entry.value["count"]!);
      final subcounty = entry.value["SubCounty"];

      print('values are:$index, $count, $subcounty');

      return FlSpot(
        index, 
        count
        );
    }).toList();

    // Populate ward data
    // wardData = wardList.asMap().entries.map((entry) {
    //   final index = entry.key.toDouble() + 1;
    //   final count = double.parse(entry.value["count"]!);
    //   return FlSpot(index, count);
    // }).toList();
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

  void _openUserProfileDialog() {
    showDialog(
      context: context,
      builder: (_) =>
          const UserProfileDialog(), // Create an instance of the dialog
    );
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
        drawer: const MyDrawer(),
        body: Container(
          constraints: const BoxConstraints.tightForFinite(),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      GestureDetector(
                          onTap: _openUserProfileDialog,
                          child: UserContainer()),
                    ],
                  ),
                ),
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
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BlueBox(total: total, name: "Mapped Plots"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      flex: 1,
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
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BlueBox(total: wards, name: "Wards"),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BlueBox(total: subcounties, name: "Sub Counties"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                const Text(
                  'SubCounties',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 26, 114, 186),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 10,
                          // getTitlesWidget: (value, meta) {
                          //   return Container(
                          //     width: 250,
                          //     child: SizedBox(
                          //       height: 300,
                          //       child: ListView.builder(
                          //         itemCount: subcountyList.length,
                          //         itemBuilder:
                          //             (BuildContext context, int index) {
                          //           final subcounty =
                          //               subcountyList[index]["SubCounty"];
                          //           return Text(subcounty!);
                          //         },
                          //       ),
                          //     ),
                          //   );
                          // },
                        )),
                      ),
                      borderData: FlBorderData(show: true),
                      gridData: FlGridData(show: true),
                      minX: 0,
                      maxX:
                          6, // Adjust this value based on the number of data points
                      minY: 0,
                      maxY: 4,
                      lineBarsData: [
                        LineChartBarData(
                          spots: subcountyData,
                          isCurved: true,
                          color: Colors.blue,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),

                // Flexible(
                //   fit: FlexFit.tight,
                //   child: Padding(
                //       padding: const EdgeInsets.only(top: 24),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text(
                //             'SubCounties',
                //             style: TextStyle(
                //                 fontSize: 16,
                //                 color: Color.fromARGB(255, 26, 114, 186),
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           Flexible(
                //             fit: FlexFit.tight,
                //             child: LineChart(
                //               LineChartData(
                //                 titlesData: FlTitlesData(
                //                   show: true,
                //                   bottomTitles: AxisTitles(
                //                       sideTitles: SideTitles(
                //                     showTitles: true,
                //                     reservedSize: 10,
                //                     getTitlesWidget: (value, meta) {
                //                       return Container(
                //                         width: 250,
                //                         child: SizedBox(
                //                           height: 300,
                //                           child: ListView.builder(
                //                             itemCount: subcountyList.length,
                //                             itemBuilder: (BuildContext context,
                //                                 int index) {
                //                               final subcounty =
                //                                   subcountyList[index]
                //                                       ["SubCounty"];
                //                               return Text(subcounty!);
                //                             },
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   )),
                //                   leftTitles: AxisTitles(
                //                     sideTitles: SideTitles(
                //                         showTitles: true,
                //                         reservedSize: 10,
                //                         getTitlesWidget: (value, _) {
                //                           return Container(
                //                             width: 250,
                //                             child: SizedBox(
                //                               height: 300,
                //                               child: ListView.builder(
                //                                 itemCount: wardList.length,
                //                                 itemBuilder:
                //                                     (BuildContext context,
                //                                         int index) {
                //                                   final count =
                //                                       subcountyList[index]
                //                                           ["count"];
                //                                   return Text(count!);
                //                                 },
                //                               ),
                //                             ),
                //                           );
                //                         }),
                //                   ),
                //                 ),
                //                 borderData: FlBorderData(show: true),
                //                 gridData: FlGridData(show: true),
                //                 minX: 0,
                //                 maxX:
                //                     6, // Adjust this value based on the number of data points
                //                 minY: 0,
                //                 maxY: 4,
                //                 lineBarsData: [
                //                   LineChartBarData(
                //                     spots: subcountyData,
                //                     isCurved: true,
                //                     color: Colors.blue,
                //                     dotData: FlDotData(show: false),
                //                     belowBarData: BarAreaData(show: true),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 8,
                //           ),
                //           const Text(
                //             'Wards',
                //             style: TextStyle(
                //                 fontSize: 16,
                //                 color: Color.fromARGB(255, 26, 114, 186),
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           Flexible(
                //             fit: FlexFit.tight,
                //             child: LineChart(
                //               LineChartData(
                //                 titlesData: FlTitlesData(
                //                   show: true,
                //                   bottomTitles: AxisTitles(
                //                       sideTitles: SideTitles(
                //                     showTitles: true,
                //                     reservedSize: 10,
                //                     getTitlesWidget: (value, meta) {
                //                       return Container(
                //                         width: 250,
                //                         child: SizedBox(
                //                           height: 300,
                //                           child: ListView.builder(
                //                             itemCount: wardList.length,
                //                             itemBuilder: (BuildContext context,
                //                                 int index) {
                //                               final wards =
                //                                   wardList[index]["Ward"];
                //                               return Text(wards!);
                //                             },
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   )),
                //                   leftTitles: AxisTitles(
                //                     sideTitles: SideTitles(
                //                         showTitles: true,
                //                         reservedSize: 10,
                //                         getTitlesWidget: (value, _) {
                //                           return Container(
                //                             width: 250,
                //                             child: SizedBox(
                //                               height: 300,
                //                               child: ListView.builder(
                //                                 itemCount: wardList.length,
                //                                 itemBuilder:
                //                                     (BuildContext context,
                //                                         int index) {
                //                                   final count =
                //                                       wardList[index]["count"];
                //                                   return Text(count!);
                //                                 },
                //                               ),
                //                             ),
                //                           );
                //                         }),
                //                   ),
                //                 ),
                //                 borderData: FlBorderData(show: true),
                //                 gridData: FlGridData(show: true),
                //                 minX: 0,
                //                 maxX: wardData.length
                //                     .toDouble(), // Adjust this value based on the number of data points
                //                 minY: 0,
                //                 maxY: wardData.length.toDouble(),
                //                 lineBarsData: [
                //                   LineChartBarData(
                //                     spots: wardData,
                //                     isCurved: true,
                //                     color: Colors.blue,
                //                     dotData: FlDotData(show: true),
                //                     belowBarData: BarAreaData(show: true),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       )),
                // ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: YellowButton(
                //     label: "Start Mapping",
                //     onButtonPressed: () {
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (_) => const MapPage()));
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
