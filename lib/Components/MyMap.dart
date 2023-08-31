// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/PlotDetailsDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/UserContainer.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';
import 'package:fsd_makueni_mobile_app/Pages/Home.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Utils.dart';
import 'dart:io';

class MyMap extends StatefulWidget {
  final double lat;
  final double lon;
  const MyMap({Key? key, required this.lat, required this.lon})
      : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late WebViewController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _showPlotDetailsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const PlotDetails();
      },
    );
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          WebView(
            initialUrl: "${getUrl()}map",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
              webViewController.evaluateJavascript(
                  "adjustMarker('${widget.lon}','${widget.lat}')");
            },
            onPageFinished: (v) {
              controller.evaluateJavascript(
                  "adjustMarker('${widget.lon}','${widget.lat}')");
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Home()));
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.bottomRight,
              child: YellowButton(
                label: "Capture Point",
                onButtonPressed: _showPlotDetailsDialog,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
