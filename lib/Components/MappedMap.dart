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

class MappedMap extends StatefulWidget {
   final double lat;
  final double lon;
  const MappedMap({Key? key,  required this.lat, required this.lon}) : super(key: key);

  @override
  State<MappedMap> createState() => _MappedMapState();
}

class _MappedMapState extends State<MappedMap> {
  late WebViewController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = null;

  void editMappedForm(Map<String, dynamic> receivedData) {
    try {
      String? valuationID = receivedData["ValuationID"];
      if (valuationID!.isNotEmpty) {
        const storage = FlutterSecureStorage();
        storage.write(key: "ValuationID", value: valuationID);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const ValuationForm()));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
      ..addJavaScriptChannel('editMappedForm',
          onMessageReceived: (JavaScriptMessage message) {
        final Map<String, dynamic> receivedData = jsonDecode(message.message);
        editMappedForm(receivedData);
      })
      ..loadRequest(Uri.parse('${getUrl()}mapped'));

    super.initState();
  }

    @override
  void didUpdateWidget(covariant MappedMap oldWidget) {
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
