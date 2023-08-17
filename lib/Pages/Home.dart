import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                    SizedBox(height: 8),
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
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: markets),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: markets),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: BlueBox(total: total, name: markets),
                        ),
                        const SizedBox(
                          width: 24,
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
            ],
          ),
        ),
      ),
    );
  }
}
