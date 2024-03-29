// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/SubmitButton.dart';
import 'package:fsd_makueni_mobile_app/Components/Utils.dart';
import 'package:fsd_makueni_mobile_app/Models/SearchItem.dart';
import 'package:fsd_makueni_mobile_app/Pages/ValuationForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPlotDetails extends StatefulWidget {
  const SearchPlotDetails({super.key});

  @override
  State<SearchPlotDetails> createState() => _PlotDetailsState();
}

class _PlotDetailsState extends State<SearchPlotDetails> {
  String plotName = '';
  String plotNumber = '';
  String parcelNo = '';
  String searchItem = 'Search';
  String check = '';
  String error = '';
  bool isChecked = false;
  String searchbox = '';
  String owner = '';
  String plotNo = '';
  var si = '';

  final storage = const FlutterSecureStorage();

  List<SearchItem> entries = <SearchItem>[];

  final _scrollController = ScrollController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _keyboardVisibility();
  }

  searchParcel(v) async {
    setState(() {
      entries.clear();
    });
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}powerbase/searchwildcard/$v"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var data = json.decode(response.body);

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(SearchItem(
              OwnerName: item["OwnerName"],
              NewPlotNumber: item["NewPlotNumber"],
              MarketName: item["MarketName"]));
        }
      });
    } catch (e) {
      // todo
    }
  }

  addAttribute() {
    storage.delete(key: "ValuationID");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ValuationForm()));
  }

  void _keyboardVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        if (isKeyboardOpen != _isKeyboardVisible) {
          setState(() {
            _isKeyboardVisible = isKeyboardOpen;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Parcel',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 85, 165)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
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
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 26, 114, 186))),
                          filled: false,
                          labelText: 'Search Owner Name',
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                      key: "NewPlotNumber",
                                      value: entries[index].NewPlotNumber);
                                  storage.delete(key: "ValuationID");
                                  entries.clear();
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ValuationForm()));
                              },
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Owner: ${entries[index].OwnerName}, Market: ${entries[index].MarketName}')),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                      var storage = const FlutterSecureStorage();
                      storage.delete(key: "ValuationID");
                      storage.delete(key: "NewPlotNumber");
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
                  if (isChecked) {
                    addAttribute();
                  } else {
                    Fluttertoast.showToast(
                      msg: "Checkbox not checked!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM, // Set gravity to TOP
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
