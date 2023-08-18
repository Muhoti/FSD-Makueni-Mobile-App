// ignore_for_file: deprecated_member_use

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';
import 'dart:io';
import 'dart:async';
import 'Utils.dart';

class MyMap extends StatefulWidget {
  final double lat;
  final double lon;
  const MyMap({super.key, required this.lat, required this.lon});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  var controller = null;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @mustCallSuper
  @protected
  void didUpdateWidget(covariant oldWidget) {
    if (controller != null) {
      controller
          .evaluateJavascript("adjustMarker('${widget.lon}','${widget.lat}')");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: WebView(
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
            )));
  }
}
