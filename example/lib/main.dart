import 'package:flutter/material.dart';
import 'dart:async';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:geo_algorithm/geo_algorithm.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getUnionPolygon();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GeoAlgorithm.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getUnionPolygon() async {
    dynamic p1 = [
      [61.0, 68.0],
      [145.0, 122.0],
      [186.0, 94.0],
      [224.0, 135.0],
      [204.0, 211.0],
      [105.0, 200.0],
      [141.0, 163.0],
      [48.0, 139.0],
      [74.0, 117.0],
      [61.0, 68.0],
    ];
    dynamic p2 = [
      [131.0, 84.0],
      [224.0, 110.0],
      [174.0, 180.0],
      [120.0, 136.0],
      [60.0, 167.0],
      [131.0, 84.0],
    ];
    dynamic union = await GeoAlgorithm.getUnionPolygon(p1, p2);
    print(union);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
