import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/UserContainer.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Pages/MapPage.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  String error = '';
  String? editing = '';
  var isLoading;

  final storage = const FlutterSecureStorage();
  dynamic data;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  getData() async {
    editing = await storage.read(key: "EDITING");

    if (editing == "TRUE") {
      try {
        var id = await storage.read(key: "NationalID");

        // Prefill Form
        try {
          final response = await get(
            Uri.parse("${getUrl()}valuation/search/$id"),
          );

          var data = await json.decode(response.body);

          setState(() {
            nationalId = id as String;
            name = data[0]["OwnerName"];
            phone = data[0]["Phone"];
            email = data[0]["Email"];
            plotNo = data[0]["NewPlotNumber"];
          });
        } catch (e) {
          print(e);
        }
      } catch (e) {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValuationForm',
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
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
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const MapPage()));
                                },
                                child: Image.asset(
                                  'assets/images/bluearrow.png', // Replace with your image asset
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            UserContainer(),
                          ],
                        ),
                      ),
                      const Text(
                        'Valuation Data',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 85, 165)),
                      ),
                      editing == "TRUE" ?
                      Text(
                        'Plot No: $plotNo',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ) : const SizedBox()
                    ],
                  ),
                ),
                MyTextInput(
                  title: 'Name',
                  lines: 1,
                  value: name,
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
                  value: phone,
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
                  value: nationalId,
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
                  value: email,
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
                    onButtonPressed: () async {
                      setState(() {
                        storage.write(key: "EDITING", value: "FALSE");
                        error = "";
                        isLoading = LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color.fromRGBO(0, 128, 0, 1),
                          size: 100,
                        );
                      });

                      var res =
                          await submitData(name, nationalId, email, phone);
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

Future<Message> submitData(
  String name,
  String nationalId,
  String email,
  String phone,
) async {
  if (name.isEmpty || nationalId.isEmpty || email.isEmpty || phone.isEmpty) {
    return Message(
        token: null, success: null, error: "All Fields Must Be Filled!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "mljwt");
    var response;

    response = await post(
      Uri.parse("${getUrl()}farmerresources"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!
      },
      body: jsonEncode(<String, String>{
        'Name': name,
        'NationalID': nationalId,
        'Email': email,
        'Phone': phone
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      return Message(
        token: null,
        success: null,
        error: "Connection to server failed!",
      );
    }
  } catch (e) {
    return Message(
      token: null,
      success: null,
      error: "Connection to server failed!",
    );
  }
}

class Message {
  var token;
  var success;
  var error;

  Message({
    required this.token,
    required this.success,
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      token: json['token'],
      success: json['success'],
      error: json['error'],
    );
  }
}
