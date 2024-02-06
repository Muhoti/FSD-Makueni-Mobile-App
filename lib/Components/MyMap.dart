// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/PlotDetailsDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/SearchPlotDetailsDialog.dart';
import 'package:fsd_makueni_mobile_app/Pages/ValuationForm.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';
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
  var isLoading = null;

  void computePointCoordinates(
      Map<String, dynamic> pointCoords, Map<String, dynamic> receivedData) {
    const storage = FlutterSecureStorage();

    print("data ${pointCoords["coordinate"][0].toString()}");

    storage.write(key: "long", value: pointCoords["coordinate"][0].toString());
    storage.write(key: "lat", value: pointCoords["coordinate"][1].toString());

    var newPlotNo = receivedData["NewPlotNumber"];

    if (newPlotNo != null) {
      print("data $newPlotNo");
      const storage = FlutterSecureStorage();
      storage.write(key: "NewPlotNumber", value: newPlotNo);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ValuationForm()));
    } else {
      _searchPlotDetailsDialog();
    }
  }

  void _searchPlotDetailsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SearchPlotDetails();
      },
    );
  }

  @override
  void initState() {
    setState(() {
      isLoading = LoadingAnimationWidget.horizontalRotatingDots(
          color: Colors.yellow, size: 100);
    });
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = null;
            });
            controller
                .runJavaScript('adjustMarker(${widget.lon},${widget.lat})');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = null;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..addJavaScriptChannel('computePointCoordinates',
          onMessageReceived: (JavaScriptMessage message) {
        // Parse the JSON data received from JavaScript
        final Map<String, dynamic> computedCoordinate =
            jsonDecode(message.message);
        final Map<String, dynamic> receivedData = jsonDecode(message.message);
        // Call the Flutter method to set 'data'
        computePointCoordinates(computedCoordinate, receivedData);
      })
      ..loadRequest(Uri.parse('${getUrl()}map'));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.runJavaScript('adjustMarker(${widget.lat},${widget.lon})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Center(
            child: isLoading,
          )
        ],
      ),
    );
  }
}
