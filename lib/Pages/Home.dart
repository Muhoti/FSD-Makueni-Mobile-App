import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';
import 'package:fsd_makueni_mobile_app/Pages/MapPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String total = '2';
  String markets = 'Wote';
  String subcounties = '';
  String wards = '';
  // List<String> makueniSubcounties = [
  //   'Kibwezi East',
  //   'Kibwezi West',
  //   'Kilome',
  //   'Makueni',
  //   'Mbooni East',
  //   'Mbooni West',
  // ];
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
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
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Align(
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
                    SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Duncan Muteti',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                          child: BlueBox(total: total, name: markets),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: markets),
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
                          child: BlueBox(total: total, name: markets),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: markets),
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
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const MapPage()));
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
