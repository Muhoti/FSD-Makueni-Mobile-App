// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Models/StatItem.dart';

class HomeItem extends StatefulWidget {
  final String label;
  final List<dynamic> list;
  const HomeItem({super.key, required this.list, required this.label});

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  void initState() {
    print("data ${widget.list}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 5.0,
            color: Colors.white24,
          ),
        ),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ))),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                    decoration: const BoxDecoration(color: Colors.white12),
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    widget.list[index]["Ward"],
                                    style: const TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 18),
                                  ),
                                ),
                                Text(
                                  widget.list[index]["Count"].toString(),
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 18),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
