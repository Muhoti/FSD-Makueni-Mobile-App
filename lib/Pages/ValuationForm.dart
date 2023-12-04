// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MySelectInput.dart';
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
  String propertyId = '';
  String marketId = '';
  String tenure = '';
  String ownername = '';
  String idnumber = '';
  String length = '';
  String width = '';
  String lr_no = '';
  String pinnumber = '';
  String landrates = '';
  String idtype = '';
  String nextofkin = '';
  String physicallocation = '';
  String postaladdress = '';
  String postalcode = '';
  String town = '';
  String mobile = '';
  String email = '';
  String gender = '';
  String coowners = '';
  String physicaladdress = '';
  String zone = '';
  String rateablevalue = '';
  String rates = '';
  String rentpayable = '';
  String rentareas = '';
  String penalty = '';
  String accumulatedpenalty = '';
  String status = '';
  String use = '';
  String blocknumber = '';
  String latitude = '';
  String longitude = '';
  String ownership = '';
  String mode = '';
  String disputed = '';
  String naturedisputed = '';
  String sitevalue = '';
  String developed = '';
  String developmnetapproved = '';
  String mainstructure = '';
  String remarks = '';
  String areainha = '';
  String accumulatedrates = '';

  String? editing = '';
  var isLoading;
  String error = '';

  final storage = const FlutterSecureStorage();
  dynamic data;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    isEditing();
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  isEditing() async {
    editing = await storage.read(key: "EDITING");
    var newPlotNo = await storage.read(key: "NewPlotNumber");

    print("editing is $editing, new plot no is $newPlotNo");
    if (editing == "TRUE") {
      getData(newPlotNo);
    } else {}
  }

  getData(String? newPlotNo) async {
    print("valuation id is : $newPlotNo");
    try {
      final response = await get(
          Uri.parse(
              "https://edams.makueni.go.ke/api/plotAPI/PropertyDetails/v1?new_plot_number=$newPlotNo"),
          headers: <String, String>{
            '486ab5a508014bb8aeebf732b3e6e591':
                '7a84a9fdca8249398ffa7b0d8ace0ead'
          });

      var data = json.decode(response.body);
      print("valuation prefilling values: $data value");
      print("One Item: ${data["property"]["property_id"]}");

      setState(() {
        propertyId = data["property"]["property_id"] ?? '';
        marketId = data["property"]["market_id"] ?? '';
        tenure = data["property"]["tenure"] ?? '';
        ownername = data["property"]["owner_name"] ?? '';
        idnumber = data["property"]["national_id"] ?? '';
        length = data["property"]["length"] ?? '';
        width = data["property"]["width"] ?? '';
        lr_no = data["property"]["LR_number"] ?? '';
        pinnumber = data["property"]["pin_number"] ?? '';
        landrates = data["property"]["land_rates"] ?? '';
        idtype = data["property"]["id_type"] ?? '';
        nextofkin = data["property"]["next_of_kin"] ?? '';
        physicallocation = data["property"]["physical_location"] ?? '';
        postaladdress = data["property"]["postal_address"] ?? '';
        postalcode = data["property"]["postal_code"] ?? '';
        town = data["property"]["postal_address_town"] ?? '';
        mobile = data["property"]["mobile_number"] ?? '';
        email = data["property"]["email"] ?? '';
        gender = data["property"]["gender"] ?? '';
        coowners = data["property"]["co_owners"] ?? '';
        physicaladdress = data["property"]["physical_address"] ?? '';
        zone = data["property"]["zone"] ?? '';
        rateablevalue = data["property"]["rateable_value"] ?? '';
        landrates = data["property"]["rate"] ?? '';
        rentpayable = data["property"]["rent_payable"] ?? '';
        rentareas = data["property"]["rent_areas"] ?? '';
        penalty = data["property"]["penalty"] ?? '';
        accumulatedpenalty = data["property"]["accumulated_penalty"] ?? '';
        status = data["property"]["status"] ?? '';
        use = data["property"]["PropertyUseDescription"] ?? '';
        blocknumber = data["property"]["BlockNumber"] ?? '';
        latitude = data["property"]["latitude"] ?? '';
        longitude = data["property"]["longitude"] ?? '';
        ownership = data["property"]["TypeOfOwnership"] ?? '';
        mode = data["property"]["ModeOfAcquisition"] ?? '';
        disputed = data["property"]["Disputed"] ?? '';
        naturedisputed = data["property"]["NatureOfDisputed"] ?? '';
        sitevalue = data["property"]["site_value"] ?? '';
        developed = data["property"]["Developed"] ?? '';
        developmnetapproved = data["property"]["DevelopmentApproved"] ?? '';
        mainstructure = data["property"]["MainStructure"] ?? '';
        remarks = data["property"]["Remarks"] ?? '';
        areainha = data["property"]["area"] ?? '';
        accumulatedrates = data["property"]["AccumulatedRates"] ?? '';
      });
    } catch (e) {
      print('the error is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        constraints: const BoxConstraints.tightForFinite(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                              'Property ID: $propertyId',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                MyTextInput(
                  title: 'MarketID',
                  lines: 1,
                  value: marketId,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      marketId = value;
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
                  title: 'Owner Name',
                  lines: 1,
                  value: ownername,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      ownername = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'ID Number',
                  lines: 1,
                  value: idnumber,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      idnumber = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Length in Ft',
                  lines: 1,
                  value: length,
                  type: TextInputType.text,
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
                  title: 'Width in Ft',
                  lines: 1,
                  value: width,
                  type: TextInputType.text,
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
                  title: 'LR Number',
                  lines: 1,
                  value: lr_no,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      lr_no = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'PIN Number',
                  lines: 1,
                  value: pinnumber,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      pinnumber = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Land Rates',
                  lines: 1,
                  value: landrates,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      landrates = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'ID Type',
                  lines: 1,
                  value: idtype,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      idtype = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Next of Kin',
                  lines: 1,
                  value: nextofkin,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      nextofkin = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Physical Location',
                  lines: 1,
                  value: physicallocation,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      physicallocation = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Postal Address',
                  lines: 1,
                  value: postaladdress,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      postaladdress = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Postal Code',
                  lines: 1,
                  value: postalcode,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      postalcode = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Postal Address Town',
                  lines: 1,
                  value: town,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      town = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Mobile Number',
                  lines: 1,
                  value: mobile,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      mobile = value;
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
                  type: TextInputType.text,
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
                  title: 'Gender',
                  lines: 1,
                  value: gender,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Co-Owners',
                  lines: 1,
                  value: coowners,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      coowners = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Physical Address',
                  lines: 1,
                  value: physicaladdress,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      physicaladdress = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Zone',
                  lines: 1,
                  value: zone,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      zone = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Rateable Value',
                  lines: 1,
                  value: rateablevalue,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      rateablevalue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Land Rate Arrears',
                  lines: 1,
                  value: landrates,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      landrates = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Rent Payable',
                  lines: 1,
                  value: rentpayable,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      rentpayable = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Rent Areas',
                  lines: 1,
                  value: rentareas,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      rentareas = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Penalty',
                  lines: 1,
                  value: penalty,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      penalty = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Accumulated Penalty',
                  lines: 1,
                  value: accumulatedpenalty,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      accumulatedpenalty = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Status',
                  lines: 1,
                  value: status,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Property Use Description',
                  lines: 1,
                  value: use,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      use = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Block Number',
                  lines: 1,
                  value: blocknumber,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      blocknumber = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Latitude',
                  lines: 1,
                  value: latitude,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      latitude = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Longitude',
                  lines: 1,
                  value: longitude,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      longitude = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Type of Ownership',
                  lines: 1,
                  value: ownership,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      ownership = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Mode of Acquisition',
                  lines: 1,
                  value: mode,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      mode = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Disputed',
                  lines: 1,
                  value: disputed,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      disputed = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Nature of Disputed',
                  lines: 1,
                  value: naturedisputed,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      naturedisputed = value;
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
                  type: TextInputType.text,
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
                  title: 'Developed',
                  lines: 1,
                  value: developed,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      developed = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Development Approved',
                  lines: 1,
                  value: developmnetapproved,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      developmnetapproved = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Main Structure',
                  lines: 1,
                  value: mainstructure,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      mainstructure = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Remarks',
                  lines: 1,
                  value: remarks,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      remarks = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Area in Ha',
                  lines: 1,
                  value: areainha,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      areainha = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Accumulated Rates',
                  lines: 1,
                  value: accumulatedrates,
                  type: TextInputType.text,
                  onSubmit: (value) {
                    setState(() {
                      accumulatedrates = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: isLoading ?? const SizedBox(),
                ),
                TextResponse(label: error),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SubmitButton(
                    label: "Submit",
                    onButtonPressed: () async {
                      setState(() {
                        storage.write(key: "EDITING", value: "FALSE");
                        error = "";
                        isLoading = LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color.fromARGB(255, 26, 114, 186),
                          size: 100,
                        );
                      });

                      var res = await submitData(
                          propertyId,
                          marketId,
                          tenure,
                          ownername,
                          idnumber,
                          length,
                          width,
                          lr_no,
                          pinnumber,
                          landrates,
                          idtype,
                          nextofkin,
                          physicallocation,
                          postaladdress,
                          postalcode,
                          town,
                          mobile,
                          email,
                          gender,
                          coowners,
                          physicaladdress,
                          zone,
                          rateablevalue,
                          landrates,
                          rentpayable,
                          rentareas,
                          penalty,
                          accumulatedpenalty,
                          status,
                          use,
                          blocknumber,
                          latitude,
                          longitude,
                          ownership,
                          mode,
                          disputed,
                          naturedisputed,
                          sitevalue,
                          developed,
                          developmnetapproved,
                          mainstructure,
                          remarks,
                          areainha,
                          accumulatedrates);
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
    String propertyId,
    String marketId,
    String newplotnumber,
    String tenure,
    String ownername,
    String idnumber,
    String length,
    String width,
    String lr_no,
    String pinnumber,
    String landrates,
    String idtype,
    String nextofkin,
    String physicallocation,
    String postaladdress,
    String postalcode,
    String town,
    String mobile,
    String email,
    String gender,
    String coowners,
    String physicaladdress,
    String zone,
    String rateablevalue,
    String rentpayable,
    String rentareas,
    String penalty,
    String accumulatedpenalty,
    String status,
    String use,
    String blocknumber,
    String latitude,
    String longitude,
    String ownership,
    String mode,
    String disputed,
    String naturedisputed,
    String sitevalue,
    String developed,
    String developmnetapproved,
    String mainstructure,
    String remarks,
    String areainha,
    String accumulatedrates) async {
  if (marketId.isEmpty ||
      newplotnumber.isEmpty ||
      tenure.isEmpty ||
      ownername.isEmpty ||
      idnumber.isEmpty) {
    return Message(
        token: null, success: null, error: "All Fields Must Be Filled!");
  }

  if (email.isEmpty || !EmailValidator.validate(email)) {
    return Message(
      token: null,
      success: null,
      error: "Email is invalid!",
    );
  }

  print("All fields are required");

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "mljwt");
    var id = await storage.read(key: "NewPlotNumber");
    var long = await storage.read(key: "long");
    var lat = await storage.read(key: "lat");

    var response;

    print("submitting id is $id");
    var editing = await storage.read(key: "EDITING");

    if (editing == 'TRUE') {
      response = await put(
        Uri.parse("${getUrl()}valuation/update/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, dynamic>{
          'PropertyID': propertyId,
          'MarketID': marketId,
          'NewPlotNumber': newplotnumber,
          'Tenure': tenure,
          'OwnerName': ownername,
          'IDNumber': idnumber,
          'LengthInFt': length,
          'WidthInFt': width,
          'LRNo': lr_no,
          'PINNumber': pinnumber,
          'LandRates': landrates,
          'IDType': idtype,
          'NextOfKin': nextofkin,
          'PhysicalLocation': physicallocation,
          'PostalAddress': postaladdress,
          'PostalCode': postalcode,
          'PostalAddressTown': town,
          'MobileNumber': mobile,
          'Email': email,
          'Gender': gender,
          'CoOwners': coowners,
          'PhysicalAddress': physicaladdress,
          'Zone': zone,
          'RateableValue': rateablevalue,
          'LandRatesArrears': landrates,
          'RentPayable': rentpayable,
          'RentAreas': rentareas,
          'Penalty': penalty,
          'AccumulatedPenalty': accumulatedpenalty,
          'Status': status,
          'PropertyUseDescription': use,
          'BlockNumber': blocknumber,
          'Latitude': latitude,
          'Longitude': longitude,
          'TypeOfOwnership': ownership,
          'ModeOfAcquisition': mode,
          'NatureOfDisputed': disputed,
          'Width': naturedisputed,
          'SiteValue': sitevalue,
          'Developed': developed,
          'DevelopmentApproved': developmnetapproved,
          'MainStructure': mainstructure,
          'Remarks': remarks,
          'AreaInHa': areainha,
          'AccumulatedRates': accumulatedrates
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
    } else {
      response = await post(
        Uri.parse("${getUrl()}valuation/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, dynamic>{
          'PropertyID': propertyId,
          'MarketID': marketId,
          'NewPlotNumber': newplotnumber,
          'Tenure': tenure,
          'OwnerName': ownername,
          'IDNumber': idnumber,
          'LengthInFt': length,
          'WidthInFt': width,
          'LRNo': lr_no,
          'PINNumber': pinnumber,
          'LandRates': landrates,
          'IDType': idtype,
          'NextOfKin': nextofkin,
          'PhysicalLocation': physicallocation,
          'PostalAddress': postaladdress,
          'PostalCode': postalcode,
          'PostalAddressTown': town,
          'MobileNumber': mobile,
          'Email': email,
          'Gender': gender,
          'CoOwners': coowners,
          'PhysicalAddress': physicaladdress,
          'Zone': zone,
          'RateableValue': rateablevalue,
          'LandRatesArrears': landrates,
          'RentPayable': rentpayable,
          'RentAreas': rentareas,
          'Penalty': penalty,
          'AccumulatedPenalty': accumulatedpenalty,
          'Status': status,
          'PropertyUseDescription': use,
          'BlockNumber': blocknumber,
          'Latitude': latitude,
          'Longitude': longitude,
          'TypeOfOwnership': ownership,
          'ModeOfAcquisition': mode,
          'NatureOfDisputed': disputed,
          'Width': naturedisputed,
          'SiteValue': sitevalue,
          'Developed': developed,
          'DevelopmentApproved': developmnetapproved,
          'MainStructure': mainstructure,
          'Remarks': remarks,
          'AreaInHa': areainha,
          'AccumulatedRates': accumulatedrates
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
