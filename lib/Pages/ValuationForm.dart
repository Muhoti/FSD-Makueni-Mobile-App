// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/MySelectInput.dart';
import 'package:fsd_makueni_mobile_app/Components/MyTextInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/TextResponse.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Models/SearchMarket.dart';
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
  List<String> subcounties = [""];
  List<String> wards = [""];
  String subcounty = '';
  String ward = '';
  String propertyId = '';
  String marketId = '';
  String marketName = '';
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
  String landratesarrears = '';
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
  String newplotno = '';

  String? editing = '';
  var isLoading;
  String error = '';
  List<SearchMarket> entries = <SearchMarket>[];

  final storage = const FlutterSecureStorage();
  dynamic data;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    isEditing();
    getSubcounties();
    super.initState();
  }

  isEditing() async {
    isLoading = LoadingAnimationWidget.horizontalRotatingDots(
        color: Colors.yellow, size: 100);
    String? newplotno = (await storage.read(key: "NewPlotNumber"));
    String? valuationID = (await storage.read(key: "ValuationID"));

    if (valuationID != null) {
      setState(() {
        error = "";
      });
      getValuation(valuationID);
    }

    if (newplotno != null) {
      setState(() {
        error = "";
        isLoading = LoadingAnimationWidget.horizontalRotatingDots(
            color: Colors.yellow, size: 100);
      });
      getData(newplotno);
    } else {}
  }

  getSubcounties() async {
    try {
      final response = await get(Uri.parse("${getUrl()}wards/subcounties"));
      var data = json.decode(response.body);
      getWards(data[0]["data"][0]);
      setState(() {
        subcounty = data[0]["data"][0];
        subcounties = (data[0]["data"] as List<dynamic>)
            .map((dynamic item) => item.toString())
            .toList();
      });
    } catch (e) {}
  }

  getWards(String subcounty) async {
    try {
      final response =
          await get(Uri.parse("${getUrl()}wards/getwards/$subcounty"));
      var data = json.decode(response.body);
      setState(() {
        ward = data[0]["data"][0];
        wards = (data[0]["data"] as List<dynamic>)
            .map((dynamic item) => item.toString())
            .toList();
      });
    } catch (e) {}
  }

  getData(String? newPlotNo) async {
    try {
      print("data $newPlotNo");
      final response = await get(
          Uri.parse(
              "https://edams.makueni.go.ke/api/plotAPI/PropertyDetails/v1?new_plot_number=$newPlotNo"),
          headers: <String, String>{
            '486ab5a508014bb8aeebf732b3e6e591':
                '7a84a9fdca8249398ffa7b0d8ace0ead'
          });

      var data = json.decode(response.body);

      setState(() {
        propertyId = data["property"]["property_id"] ?? '';
        marketId = data["property"]["market_id"] ?? '';
        marketName = data["property"]["market_name"] ?? '';
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
        isLoading = null;
      });
    } catch (e) {
      setState(() {
        isLoading = null;
      });
    }
  }

  getValuation(String? ValuationID) async {
    try {
      final response =
          await get(Uri.parse("${getUrl()}valuation/$ValuationID"));

      var data = json.decode(response.body);
      if ((data as List<dynamic>).length > 0) {
        data = data[0];
        print("data $data");

        setState(() {
          subcounty = data["SubCounty"].toString();
          marketId = data["MarketID"].toString();
          marketName = data["MarketName"].toString();
          tenure = data["Tenure"].toString();
          ownername = data["OwnerName"].toString();
          idnumber = data["IDNumber"].toString();
          length = data["LengthInFt"].toString();
          width = data["WidthInFt"].toString();
          lr_no = data["LR_number"].toString();
          pinnumber = data["PINNumber"].toString();
          landrates = data["LandRates"].toString();
          idtype = data["IDType"].toString();
          nextofkin = data["NextOfKin"].toString();
          physicallocation = data["PhysicalLocation"].toString();
          postaladdress = data["PostalAddress"].toString();
          postalcode = data["PostalCode"].toString();
          town = data["PostalAddressTown"].toString();
          mobile = data["MobileNumber"].toString();
          email = data["Email"].toString();
          gender = data["Gender"].toString();
          coowners = data["CoOwners"].toString();
          physicaladdress = data["PhysicalAddress"].toString();
          zone = data["Zone"].toString();
          rateablevalue = data["RateableValue"].toString();
          rentpayable = data["RentPayable"].toString();
          rentareas = data["RentArreas"].toString();
          penalty = data["Penalty"].toString();
          accumulatedpenalty = data["AccumulatedPenalty"].toString();
          status = data["Status"].toString();
          use = data["PropertyUseDescription"].toString();
          blocknumber = data["BlockNumber"].toString();
          ownership = data["TypeOfOwnership"].toString();
          mode = data["ModeOfAcquisition"].toString();
          disputed = data["Disputed"].toString();
          naturedisputed = data["NatureOfDisputed"].toString();
          sitevalue = data["SiteValue"].toString();
          developed = data["Developed"].toString();
          developmnetapproved = data["DevelopmentApproved"].toString();
          mainstructure = data["MainStructure"].toString();
          remarks = data["Remarks"].toString();
          areainha = data["AreaInHa"].toString();
          accumulatedrates = data["AccumulatedRates"].toString();
          isLoading = null;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = null;
      });
    }
  }

  searchMarket(String value) async {
    try {
      final response =
          await get(Uri.parse("${getUrl()}powerbase/searchmarket/$value"));

      var data = json.decode(response.body);
      if ((data as List<dynamic>).length > 0) {
        print("data $data");
        setState(() {
          entries.clear();
          for (var item in data) {
            entries.add(SearchMarket(
                MarketName: item["MarketName"],
                MarketID: item["MarketID"],
                MarketCode: item["MarketCode"]));
          }
        });
      }
    } catch (e) {}
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  calculateArea(double lengthInFeet, double widthInFeet) {
    double lengthInMeters = lengthInFeet * 0.3048;
    double widthInMeters = widthInFeet * 0.3048;
    double areaInSquareMeters = lengthInMeters * widthInMeters;
    double areaInHectares = areaInSquareMeters / 10000.0;
    setState(() {
      areainha = areaInHectares.toStringAsFixed(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(26, 114, 186, 1),
                Color.fromRGBO(49, 161, 254, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: _openDrawer,
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                "Valuation Form",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MapPage()));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('Owner Information',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                    MyTextInput(
                      title: 'Phone Number',
                      lines: 1,
                      value: mobile,
                      type: TextInputType.phone,
                      onSubmit: (value) {
                        setState(() {
                          mobile = value;
                        });
                      },
                    ),
                    MyTextInput(
                      title: 'Email (optional)',
                      lines: 1,
                      value: email,
                      type: TextInputType.emailAddress,
                      onSubmit: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          child: MySelectInput(
                              label: 'ID Type',
                              onSubmit: (value) {
                                setState(() {
                                  idtype = value;
                                });
                              },
                              list: const ['ID', 'Passport'],
                              value: idtype),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: MyTextInput(
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
                        )
                      ],
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
                    MyTextInput(
                      title: 'Next of Kin (optional)',
                      lines: 1,
                      value: nextofkin,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        setState(() {
                          nextofkin = value;
                        });
                      },
                    ),
                    MySelectInput(
                        label: 'Gender',
                        onSubmit: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        list: const ['', 'Male', 'Female'],
                        value: gender),
                    MyTextInput(
                      title: 'Co-Owners (optional)',
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
                      height: 16,
                    ),
                    const Text('Plot Details',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                        list: const ['', 'Freehold', 'Leasehold'],
                        value: tenure),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextInput(
                            title: 'Length (Ft)',
                            lines: 1,
                            value: length,
                            type: TextInputType.number,
                            onSubmit: (value) {
                              setState(() {
                                length = value;
                              });
                              if (width.isNotEmpty && length.isNotEmpty) {
                                calculateArea(double.tryParse(length)!,
                                    double.tryParse(width)!);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyTextInput(
                            title: 'Width (Ft)',
                            lines: 1,
                            value: width,
                            type: TextInputType.number,
                            onSubmit: (value) {
                              setState(() {
                                width = value;
                              });
                              if (width.isNotEmpty && length.isNotEmpty) {
                                calculateArea(double.tryParse(length)!,
                                    double.tryParse(width)!);
                              }
                            },
                          ),
                        ),
                      ],
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
                    Row(
                      children: [
                        Expanded(
                          child: MyTextInput(
                            title: 'Site Value',
                            lines: 1,
                            value: sitevalue,
                            type: TextInputType.number,
                            onSubmit: (value) {
                              setState(() {
                                sitevalue = value;
                              });
                              if (sitevalue.isNotEmpty) {
                                setState(() {
                                  landrates =
                                      (double.tryParse(sitevalue)! * 0.04)
                                          .toStringAsFixed(0);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyTextInput(
                            title: 'Land Rate',
                            lines: 1,
                            value: landrates,
                            type: TextInputType.number,
                            onSubmit: (value) {
                              setState(() {
                                landrates = value;
                              });
                              if (landrates.isNotEmpty) {
                                setState(() {
                                  sitevalue =
                                      (double.tryParse(landrates)! / 0.04)
                                          .toStringAsFixed(0);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MySelectInput(
                              label: 'Sub County',
                              onSubmit: (value) {
                                getWards(value);
                                setState(() {
                                  subcounty = value;
                                });
                              },
                              list: subcounties,
                              value: subcounty),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MySelectInput(
                              label: 'Ward',
                              onSubmit: (value) {
                                setState(() {
                                  ward = value;
                                });
                              },
                              list: wards,
                              value: subcounty),
                        ),
                      ],
                    ),
                    MyTextInput(
                      title: 'Market (Type to search)',
                      lines: 1,
                      value: marketName,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        searchMarket(value);
                      },
                    ),
                    entries.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Card(
                              elevation: 12,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: ListView.separated(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: entries.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextButton(
                                      onPressed: () {
                                        setState(() {
                                          marketId = entries[index].MarketID;
                                          marketName =
                                              entries[index].MarketName;
                                          newplotno = entries[index].MarketCode;
                                          entries.clear();
                                        });
                                      },
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              'Market: ${entries[index].MarketName}')),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 10,
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Other Details (optional)',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                    MyTextInput(
                      title: 'Rateable Value',
                      lines: 1,
                      value: rateablevalue,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          rateablevalue = value;
                        });
                      },
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
                    MyTextInput(
                      title: 'Rent Payable',
                      lines: 1,
                      value: rentpayable,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          rentpayable = value;
                        });
                      },
                    ),
                    MyTextInput(
                      title: 'Rent Areas',
                      lines: 1,
                      value: rentareas,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          rentareas = value;
                        });
                      },
                    ),
                    MyTextInput(
                      title: 'Penalty',
                      lines: 1,
                      value: penalty,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          penalty = value;
                        });
                      },
                    ),
                    MyTextInput(
                      title: 'Accumulated Penalty',
                      lines: 1,
                      value: accumulatedpenalty,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          accumulatedpenalty = value;
                        });
                      },
                    ),
                    MySelectInput(
                        label: 'Status',
                        onSubmit: (value) {
                          setState(() {
                            status = value;
                          });
                        },
                        list: const ['Select Status', '1', '0'],
                        value: status),
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
                    MySelectInput(
                        label: 'Type of Ownership',
                        onSubmit: (value) {
                          setState(() {
                            ownership = value;
                          });
                        },
                        list: const [
                          '--Type of Ownership--',
                          'Individual',
                          'Group',
                          'Private Institution'
                        ],
                        value: ownership),
                    MySelectInput(
                        label: 'Mode of Acquisition',
                        onSubmit: (value) {
                          setState(() {
                            mode = value;
                          });
                        },
                        list: const [
                          '--Mode of Acquisition--',
                          'Purchased',
                          'Allotment'
                        ],
                        value: mode),
                    MySelectInput(
                        label: 'Disputed',
                        onSubmit: (value) {
                          setState(() {
                            disputed = value;
                          });
                        },
                        list: const ['--Select Option--', 'Yes', 'No'],
                        value: disputed),
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
                    MyTextInput(
                      title: 'Accumulated Rates',
                      lines: 1,
                      value: accumulatedrates,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          accumulatedrates = value;
                        });
                      },
                    ),
                    TextResponse(label: error),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SubmitButton(
                        label: "Submit",
                        onButtonPressed: () async {
                          setState(() {
                            error = "";
                            isLoading =
                                LoadingAnimationWidget.staggeredDotsWave(
                              color: const Color.fromARGB(255, 26, 114, 186),
                              size: 100,
                            );
                          });

                          var res = await submitData(
                              newplotno,
                              ward,
                              subcounty,
                              marketId,
                              marketName,
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
                              landratesarrears,
                              rentpayable,
                              rentareas,
                              penalty,
                              accumulatedpenalty,
                              status,
                              use,
                              blocknumber,
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Home()));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: isLoading ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}

Future<Message> submitData(
    String newplotno,
    String ward,
    String subcounty,
    String marketId,
    String marketName,
    String tenure,
    String ownername,
    String idnumber,
    String length,
    String width,
    String lrno,
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
    String landratesarrears,
    String rentpayable,
    String rentareas,
    String penalty,
    String accumulatedpenalty,
    String status,
    String use,
    String blocknumber,
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
      marketName.isEmpty ||
      tenure.isEmpty ||
      ownername.isEmpty ||
      idnumber.isEmpty ||
      length.isEmpty ||
      width.isEmpty ||
      gender.isEmpty ||
      pinnumber.isEmpty ||
      landrates.isEmpty ||
      sitevalue.isEmpty ||
      mobile.isEmpty ||
      areainha.isEmpty ||
      tenure.isEmpty) {
    return Message(
        token: null, success: null, error: "Some mandatory fields are blank!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "mljwt");
    String? newplotnumber = await storage.read(key: "NewPlotNumber");
    String? valuationID = await storage.read(key: "ValuationID");
    var long = await storage.read(key: "long");
    var lat = await storage.read(key: "lat");
    var response;
    var fieldOfficer = await storage.read(key: "id");

    storage.delete(key: "NewPlotNumber");
    storage.delete(key: "ValuationID");
    storage.delete(key: "id");
    storage.delete(key: "long");
    storage.delete(key: "lat");

    if (valuationID != null) {
      response = await put(
        Uri.parse("${getUrl()}valuation/update/$valuationID"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, dynamic>{
          'Ward': ward,
          'SubCounty': subcounty,
          'MarketID': marketId,
          'MarketName': marketName,
          'NewPlotNumber': newplotnumber ?? newplotno,
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
          'Latitude': lat,
          'Longitude': long,
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
          'AccumulatedRates': accumulatedrates,
          'FirstApprover': '',
          'SecondApprover': '',
          'FieldOfficer': fieldOfficer
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
          'Ward': ward,
          'SubCounty': subcounty,
          'MarketID': marketId,
          'MarketName': marketName,
          'NewPlotNumber': newplotnumber ?? newplotno,
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
          'Latitude': lat,
          'Longitude': long,
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
          'AccumulatedRates': accumulatedrates,
          'FirstApprover': '',
          'SecondApprover': '',
          'FieldOfficer': fieldOfficer
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
      error: "Connection to server failed!!",
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
