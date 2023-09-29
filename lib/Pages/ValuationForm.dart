// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextResponse.dart';
import 'package:fsd_makueni_mobile_app/Components/UserContainer.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
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
  String subcounty = '';
  String ward = '';
  String market = '';
  String plotNo = '';
  String lrNo = '';
  String tenure = '';
  String landuse = '';
  String length = '';
  String width = '';
  String area = '';
  String unit = '';
  String rate = '';
  String sitevalue = '';
  String parcelNo = '';
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
            Uri.parse("${getUrl()}valuation/searchid/$id"),
          );

          var data = await json.decode(response.body);

          setState(() {
            nationalId = id as String;
            name = data[0]["OwnerName"];
            phone = data[0]["Phone"];
            email = data[0]["Email"];
            plotNo = data[0]["NewPlotNumber"];
            subcounty = data[0]["SubCounty"];
            ward = data[0]["Ward"];
            market = data[0]["Market"];
            lrNo = data[0]["LR_Number"];
            tenure = data[0]["Tenure"];
            landuse = data[0]["LandUse"];
            length = data[0]["Length"];
            width = data[0]["Width"];
            area = data[0]["Area"];
            unit = data[0]["Unit_of_Area"];
            rate = data[0]["Rate"];
            sitevalue = data[0]["SiteValue"];
            parcelNo = data[0]["ParcelNo"];
          });

          print("valuation data is $data");
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
                      editing == "TRUE"
                          ? Text(
                              'Plot No: $plotNo',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                TextResponse(label: error),
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
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'SubCounty',
                  lines: 1,
                  value: subcounty,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      subcounty = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Ward',
                  lines: 1,
                  value: ward,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      ward = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Market',
                  lines: 1,
                  value: market,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      market = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'New Plot Number',
                  lines: 1,
                  value: plotNo,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      plotNo = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'LR Number',
                  lines: 1,
                  value: lrNo,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      lrNo = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Tenure',
                  lines: 1,
                  value: tenure,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      tenure = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Land Use',
                  lines: 1,
                  value: landuse,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      landuse = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Length',
                  lines: 1,
                  value: length,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      length = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Width',
                  lines: 1,
                  value: width,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      width = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Area',
                  lines: 1,
                  value: area,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      area = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Unit of Acreage',
                  lines: 1,
                  value: unit,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      unit = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Rate',
                  lines: 1,
                  value: rate,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      rate = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Site Value',
                  lines: 1,
                  value: sitevalue,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      sitevalue = value;
                    });
                  },
                ),
                 const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Parcel No',
                  lines: 1,
                  value: parcelNo,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      parcelNo = value;
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
                          await submitData(
subcounty, ward, market, name, phone, nationalId, email, plotNo, lrNo, tenure, landuse, length, width, area, unit, rate, sitevalue, parcelNo
                            
                            );
                      setState(() {
                        isLoading = null;
                        if (res.error == null) {
                          error = res.success;
                        } else {
                          error = res.error;
                        }
                      });
                      if (res.error == null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Home()));
                      }
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
    String subcounty,
  String ward ,
  String market,
  String name,
 String phone,
  String nationalId ,
  String email ,
  String plotNo ,
  String lrNo,
  String tenure ,
  String landuse,
  String length ,
  String width,
  String area,
  String unit,
  String rate,
  String sitevalue,
  String parcelNo ,
) async {
  if (name.isEmpty || nationalId.isEmpty || email.isEmpty || phone.isEmpty) {
    return Message(
        token: null, success: null, error: "All Fields Must Be Filled!");
  }

  print("All fields are required");

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "mljwt");
    var response;

    response = await post(
      Uri.parse("${getUrl()}valuation/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!
      },
      body: jsonEncode(<String, String>{
        'SubCounty': name,
        'Ward': nationalId,
        'Market': email,
        'OwnerName': phone,
        'Phone': name,
        'NationalID': nationalId,
        'Email': email,
        'NewPlotNumber': phone,
        'LR_Number': name,
        'Tenure': nationalId,
        'LandUse': email,
        'Length': phone,
        'Width': name,
        'Unit_of_Area': nationalId,
        'Rate': email,
        'SiteValue': phone,
        'ParcelNo': parcelNo
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
