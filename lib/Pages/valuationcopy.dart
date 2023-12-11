// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, non_constant_identifier_names

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

class ValuationFormCopy extends StatefulWidget {
  const ValuationFormCopy({super.key});

  @override
  State<ValuationFormCopy> createState() => _ValuationFormState();
}

class _ValuationFormState extends State<ValuationFormCopy> {
  int propertyId = 0;
  int marketId = 0;
  int? newPlotNo = 0;
  String tenure = '';
  String ownername = '';
  String idnumber = '';
  double length = 0.0;
  double width = 0.0;
  String lr_no = '';
  String pinnumber = '';
  double? landrates = 0.0;
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
  double rateablevalue = 0.0;
  String landratesarrears = '';
  double rentpayable = 0.0;
  double rentareas = 0.0;
  double penalty = 0.0;
  double accumulatedpenalty = 0.0;
  int status = 1;
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
  double accumulatedrates = 0.0;

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
    var edit = await storage.read(key: "EDITING");
    var newplotno = int.parse((await storage.read(key: "NewPlotNumber"))!);
    setState(() {
      editing = edit;
      newPlotNo = newplotno;
    });

    print("editing is $editing, new plot no is $newPlotNo");
    if (editing == "TRUE") {
      getData(newPlotNo);
    } else {}
  }

  getData(int? newPlotNo) async {
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
      print("propertyId Item: ${data["property"]["property_id"]}");

      setState(() {
        propertyId = int.parse(data["property"]["property_id"] ?? 0);
        print("property id: $propertyId");
        marketId = int.parse(data["property"]["market_id"] ?? 0);
        print("marketId id: $marketId");

        tenure = data["property"]["tenure"] ?? '';
        print("tenure id: $tenure");

        ownername = data["property"]["owner_name"] ?? '';
        print("ownername id: $ownername");
        // idnumber = data["property"]["national_id"] ?? '';
        // print("idnumber id: $idnumber");

        length = double.parse(data["property"]["length"] ?? 0.0);
        print("length id: $length");

        width = double.parse(data["property"]["width"] ?? 0.0);
        print("width: $width");

        lr_no = data["property"]["LR_number"] ?? '';
        print("lr_no: $lr_no");

        // pinnumber = data["property"]["pin_number"] ?? 'PN008';
        // print("pinnumber: $pinnumber");

        // landrates = double.tryParse(data["property"]["land_rates"] ?? 0.0);
        // print("landrates: $landrates");

        // idtype = data["property"]["id_type"] ?? '';
        // print("idtype: $idtype");

        // nextofkin = data["property"]["next_of_kin"] ?? '';
        // print("nextofkin: $nextofkin");

        // physicallocation = data["property"]["physical_location"] ?? '';
        // print("physicallocation: $physicallocation");

        // postaladdress = data["property"]["postal_address"] ?? '';
        // print("postaladdress: $postaladdress");

        // postalcode = data["property"]["postal_code"] ?? '';
        // print("postalcode: $postalcode");

        // town = data["property"]["postal_address_town"] ?? '';
        // print("town: $town");

        // mobile = data["property"]["mobile_number"] ?? '';
        // print("mobile: $mobile");

        // email = data["property"]["email"] ?? '';
        // print("widemailth: $email");

        // gender = data["property"]["gender"] ?? '';
        // print("gender: $gender");

        // coowners = data["property"]["co_owners"] ?? '';
        // print("coowners: $coowners");

        // physicaladdress = data["property"]["physical_address"] ?? '';
        // print("physicaladdress: $physicaladdress");

        // zone = data["property"]["zone"] ?? '';
        // print("zone: $zone");

        // rateablevalue = double.parse(data["property"]["rateable_value"] ?? 0.0);
        // print("rateablevalue: $rateablevalue");

        landratesarrears = data["property"]["rate"] ?? '';
        print("landratesarrears: $landratesarrears");

        // rentpayable = double.parse(data["property"]["rent_payable"] ?? 0.0);
        // print("rentpayable: $rentpayable");

        // rentareas = double.parse(data["property"]["rent_areas"] ?? 0.0);
        // print("rentareas: $rentareas");

        // penalty = double.parse(data["property"]["penalty"] ?? 0.0);
        // print("penalty: $penalty");

        // accumulatedpenalty =
        //     double.parse(data["property"]["accumulated_penalty"] ?? 0.0);
        // print("accumulatedpenalty: $accumulatedpenalty");

        // status = data["property"]["status"] ?? '';
        // print("status: $status");

        // use = data["property"]["PropertyUseDescription"] ?? '';
        // print("use: $use");

        // blocknumber = data["property"]["BlockNumber"] ?? '';
        // print("blocknumber: $blocknumber");

        latitude = data["property"]["latitude"] ?? '';
        print("latitude: $latitude");

        longitude = data["property"]["longitude"] ?? '';
        print("longitude: $longitude");

        // ownership = data["property"]["TypeOfOwnership"] ?? '';
        // print("ownership: $ownership");

        // mode = data["property"]["ModeOfAcquisition"] ?? '';
        // print("mode: $mode");

        // disputed = data["property"]["Disputed"] ?? '';
        // print("disputed: $disputed");

        // naturedisputed = data["property"]["NatureOfDisputed"] ?? '';
        // print("naturedisputed: $naturedisputed");

        sitevalue = data["property"]["site_value"] ?? '';
        print("sitevalue: $sitevalue");

        // developed = data["property"]["Developed"] ?? '';
        // print("developed: $developed");

        // developmnetapproved = data["property"]["DevelopmentApproved"] ?? '';
        // print("developmnetapproved: $developmnetapproved");

        // mainstructure = data["property"]["MainStructure"] ?? '';
        // print("mainstructure: $mainstructure");

        // remarks = data["property"]["Remarks"] ?? '';
        // print("remarks: $remarks");

        areainha = data["property"]["area"] ?? '';
        print("areainha: $areainha");

        // accumulatedrates =
        //     double.parse(data["property"]["AccumulatedRates"] ?? 0.0);
        // print("accumulatedrates: $accumulatedrates");
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      marketId = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MySelectInput(
                    label: 'Tenure',
                    onSubmit: (value) {
                      setState(() {
                        tenure = value;
                      });
                    },
                    entries: const [
                      '--Select Tenure--',
                      'Private Land',
                      'Public Land'
                    ],
                    value: tenure),
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
                MySelectInput(
                    label: 'ID Type',
                    onSubmit: (value) {
                      setState(() {
                        idtype = value;
                      });
                    },
                    entries: const ['National ID', 'Passport'],
                    value: idtype),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'ID/Passport Number',
                  lines: 1,
                  value: idnumber,
                  type: TextInputType.number,
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      length = double.parse(value);
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      width = double.parse(value);
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      landrates = double.parse(value);
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
                  type: TextInputType.phone,
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
                MySelectInput(
                    label: 'Gender',
                    onSubmit: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    entries: ['--Select Gender--', 'Male', 'Female'],
                    value: gender),
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      rateablevalue = double.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                  title: 'Land Rate Arrears',
                  lines: 1,
                  value: landratesarrears,
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      landratesarrears = value;
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      rentpayable = double.parse(value);
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      rentareas = double.parse(value);
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      penalty = double.parse(value);
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      accumulatedpenalty = double.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MySelectInput(
                    label: 'Status',
                    onSubmit: (value) {
                      setState(() {
                        status = int.parse(value);
                      });
                    },
                    entries: const ['1', '0'],
                    value: status.toString()),
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
                MySelectInput(
                    label: 'Type of Ownership',
                    onSubmit: (value) {
                      setState(() {
                        ownership = value;
                      });
                    },
                    entries: const [
                      '--Type of Ownership--',
                      'Individual',
                      'Group',
                      'Private Institution'
                    ],
                    value: ownership),
                const SizedBox(
                  height: 10,
                ),
                MySelectInput(
                    label: 'Mode of Acquisition',
                    onSubmit: (value) {
                      setState(() {
                        mode = value;
                      });
                    },
                    entries: const [
                      '--Mode of Acquisition--',
                      'Purchased',
                      'Allotment'
                    ],
                    value: mode),
                const SizedBox(
                  height: 10,
                ),
                MySelectInput(
                    label: 'Disputed',
                    onSubmit: (value) {
                      setState(() {
                        disputed = value;
                      });
                    },
                    entries: ['--Select Option--', 'Yes', 'No'],
                    value: disputed),
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
                  type: TextInputType.number,
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
                  type: TextInputType.number,
                  onSubmit: (value) {
                    setState(() {
                      accumulatedrates = double.parse(value);
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
                        // storage.write(key: "EDITING", value: "FALSE");
                        error = "";
                        isLoading = LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color.fromARGB(255, 26, 114, 186),
                          size: 100,
                        );
                      });

                      var res = await submitData(
                          propertyId,
                          marketId,
                          newPlotNo,
                          tenure,
                          ownername,
                          idnumber,
                          length,
                          width,
                          lr_no,
                          pinnumber,
                          landrates!,
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
                          landratesarrears,
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
    int propertyId,
    int marketId,
    int? newPlotNo,
    String tenure,
    String ownername,
    String idnumber,
    double length,
    double width,
    String lrno,
    String pinnumber,
    double landrates,
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
    double rateablevalue,
    String landratesarrears,
    double rentpayable,
    double rentareas,
    double penalty,
    double accumulatedpenalty,
    int status,
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
    double accumulatedrates) async {
  if (marketId == 0 ||
      newPlotNo == 0 ||
      tenure.isEmpty ||
      ownername.isEmpty ||
      idnumber.isEmpty ||
      length == 0.0 ||
      width == 0.0 ||
      lrno.isEmpty ||
      pinnumber.isEmpty) {
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

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "mljwt");
    var id = await storage.read(key: "NewPlotNumber");
    // var long = await storage.read(key: "long");
    // var lat = await storage.read(key: "lat");

    var response;

    print("submitting id is $id");
    var editing = await storage.read(key: "EDITING");

    print('editing form is $editing');

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
          'NewPlotNumber': newPlotNo,
          'Tenure': tenure,
          'OwnerName': ownername,
          'IDNumber': idnumber,
          'LengthInFt': length,
          'WidthInFt': width,
          'LRNo': lrno,
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
          'LandRatesArrears': landratesarrears,
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
          'Disputed': disputed,
          'NatureOfDisputed': naturedisputed,
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
          error: "Connection to server failed",
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
          'NewPlotNumber': newPlotNo,
          'Tenure': tenure,
          'OwnerName': ownername,
          'IDNumber': idnumber,
          'LengthInFt': length,
          'WidthInFt': width,
          'LRNo': lrno,
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
          'LandRatesArrears': landratesarrears,
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
          'Disputed': disputed,
          'NatureOfDisputed': naturedisputed,
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
    print('the error is $e');
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
