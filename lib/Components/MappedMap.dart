// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fsd_makueni_mobile_app/Components/MyDrawer.dart';
import 'package:fsd_makueni_mobile_app/Components/PlotDetailsDialog.dart';
import 'package:fsd_makueni_mobile_app/Components/SearchPlotDetailsDialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:fsd_makueni_mobile_app/Components/YellowButton.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Utils.dart';
import 'dart:io';

class MappedMap extends StatefulWidget {
  const MappedMap({Key? key}) : super(key: key);

  @override
  State<MappedMap> createState() => _MappedMapState();
}

class _MappedMapState extends State<MappedMap> {
  late WebViewController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = null;

  void editMappedForm(Map<String, dynamic> receivedData) {
    var valuationID = receivedData["ValuationID"];
    print("data ${valuationID}");
  }

  @override
  void initState() {
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
          onPageStarted: (String url) {
            setState(() {
              isLoading = LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.yellow, size: 100);
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = null;
            });
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
