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
  @override
  void initState() {
    super.initState();
  }

  Future<void> union() async {
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

  Future<void> dissolve() async {
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
      [105.0, 200.0],
      [48.0, 139.0],
    ];
    dynamic result = await GeoAlgorithm.dissolvePolygon(p1, p2);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text("合并"),
                onPressed: () => union(),
              ),
              FlatButton(
                child: Text("分割"),
                onPressed: () => dissolve(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
