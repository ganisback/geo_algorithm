import 'dart:async';

import 'package:flutter/services.dart';

class GeoAlgorithm {
  static const MethodChannel _channel = const MethodChannel('geo_algorithm');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> getUnionPolygon(dynamic p1, dynamic p2) async {
    final dynamic union =
        await _channel.invokeMethod('getUnionPolygon', [p1, p2]);
    return union;
  }

  static Future<dynamic> dissolvePolygon(dynamic p1, dynamic p2) async {
    final dynamic polys =
        await _channel.invokeMethod('dissolvePolygon', [p1, p2]);
    return polys;
  }
}
