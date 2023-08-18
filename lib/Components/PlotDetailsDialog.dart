import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MySelectInput.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Models/SearchItem.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:fsd_makueni_mobile_app/Pages/ValuationForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlotDetails extends StatefulWidget {
  const PlotDetails({super.key});

  @override
  State<PlotDetails> createState() => _PlotDetailsState();
}

class _PlotDetailsState extends State<PlotDetails> {
  String plotName = '';
  String plotNumber = '';
  String searchItem = 'Name';
  String check = '';
  String error = '';
  bool isChecked = false;

  final storage = const FlutterSecureStorage();

  List<SearchItem> entries = <SearchItem>[];

  searchParcel(v) async {
    setState(() {
      entries.clear();
    });
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}workplan/searchfarmer/$v"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var data = json.decode(response.body);

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(SearchItem(item["Name"], item["NationalID"]));
        }
      });
    } catch (e) {
      // todo
    }
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
              Text("LR No/Parcel No: $plotName",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              Text("Approved Parcel No: $plotNumber",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Search Parcel',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 85, 165)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MySelectInput(
                      onSubmit: (searchParameter) {
                        setState(() {
                          searchItem = searchParameter;
                        });
                      },
                      entries: const [
                        "Name",
                        "Phone",
                        "National ID",
                        "Parcel No"
                      ],
                      value: searchItem),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                      child: TextField(
                        onChanged: (value) {
                          if (value.characters.length >=
                              check.characters.length) {
                            searchParcel(value);
                          } else {
                            setState(() {
                              entries.clear();
                            });
                          }
                          setState(() {
                            check = value;
                            error = '';
                          });
                        },
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 26, 114, 186))),
                            filled: false,
                            labelText: "Parcel No.",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 26, 114, 186)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                      ),
                    ),
                  )
                ],
              ),
              entries.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Card(
                        elevation: 12,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: entries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TextButton(
                                onPressed: () {
                                  setState(() {
                                    storage.write(
                                        key: "NationalID",
                                        value: entries[index].NationalID);
                                    entries.clear();
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                },
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Name: ${entries[index].Name} \n ID: ${entries[index].NationalID}')),
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
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  const Text(
                    'No match found?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SubmitButton(
                  label: "New Valuation Record",
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
    );
  }
}
