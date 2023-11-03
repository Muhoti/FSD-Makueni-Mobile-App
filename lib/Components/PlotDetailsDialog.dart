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

class PlotDetails extends StatefulWidget {
  final dynamic data;

  const PlotDetails({super.key, required this.data});

  @override
  State<PlotDetails> createState() => _PlotDetailsState();
}

class _PlotDetailsState extends State<PlotDetails> {
  String id = '';
  String? plotNo = '';
  String nationalid = '';
  String ownername = '';
  String parcelno = '';
  String phone = '';

  String error = '';
  bool isChecked = false;
  String searchbox = '';

  final storage = const FlutterSecureStorage();

  updateParcelDetails(data) {
    print("dialog plot no is $plotNo");
    storage.write(key: "NewPlotNumber", value: plotNo);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ValuationForm()));
  }

  @override
  void initState() {
    print("dialog data is ${widget.data["NationalID"]}");
    setState(() {
      id = widget.data["ValuationID"];
      plotNo = widget.data["NewPlotNumber"];
      parcelno = widget.data["ParcelNo"];
      nationalid = widget.data["NationalID"];
      ownername = widget.data["OwnerName"];
    });
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
              Text("New Plot No: $plotNo",
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
              Text("NationalID: $nationalid",
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
