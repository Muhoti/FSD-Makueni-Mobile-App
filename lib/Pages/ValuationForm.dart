import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Components/BlueBox.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextLarge.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';

class ValuationForm extends StatefulWidget {
  const ValuationForm({super.key});

  @override
  State<ValuationForm> createState() => _ValuationFormState();
}

class _ValuationFormState extends State<ValuationForm> {
  String name = '';
  String phone = '';
  String nationalId = '';
  String email = '';
  String plotNo = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValuationForm',
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Valuation Data',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 85, 165)),
                      ),
                      Text(
                        'Plot No: $plotNo',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                MyTextInput(
                  title: 'Name',
                  lines: 1,
                  value: '',
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Phone',
                  lines: 1,
                  value: '',
                  type: TextInputType.phone,
                  onSubmit: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'National ID',
                  lines: 1,
                  value: '',
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      nationalId = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Email',
                  lines: 1,
                  value: '',
                  type: TextInputType.emailAddress,
                  onSubmit: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SubmitButton(
                    label: "Submit",
                    onButtonPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ValuationForm()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
