import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MySelectInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Models/SearchItem.dart';
import 'package:fsd_makueni_mobile_app/Pages/ValuationForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class PlotDetails extends StatefulWidget {
  final dynamic data;

  const PlotDetails({super.key, required this.data});

  @override
  State<PlotDetails> createState() => _PlotDetailsState();
}

class _PlotDetailsState extends State<PlotDetails> {
  String id = '';
  String? newPlotNo = '';
  String? nationalid = '';
  String ownername = '';
  String parcelno = '';
  String phone = '';

  String error = '';
  bool isChecked = false;
  String searchbox = '';

  final storage = const FlutterSecureStorage();

  updateParcelDetails(data) {
    print("dialog plot no is $newPlotNo");
    storage.write(key: "NewPlotNumber", value: newPlotNo);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ValuationForm()));
  }

  comparePowerBaseData() async {
    setState(() {});
    try {
      var plotNo = widget.data["NewPlotNumber"];
      final response = await get(
        Uri.parse("${getUrl()}powerbase/$plotNo"),
      );

      var data = json.decode(response.body);
      print("powerbase data: ${data} ");
      setState(() {
        newPlotNo = data[0]["NewPlotNumber"];
        id = data[0]["NewPlotNumber"];
        parcelno = data[0]["ParcelNo"];
        ownername = data[0]["OwnerName"];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    comparePowerBaseData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plot Details',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 85, 165)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("New Plot No: $newPlotNo",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 20,
              ),
              Text("Parcel No: $parcelno",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 20,
              ),
              Text("Owner Name: $ownername",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 20,
              ),
              Text("NationalID: $id",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Approved Parcel No: $parcelno",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              Align(
                alignment: Alignment.bottomCenter,
                child: SubmitButton(
                  label: "Update Details",
                  onButtonPressed: () {
                    updateParcelDetails(widget.data);
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
