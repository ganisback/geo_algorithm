import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class GeoAlgorithm {
  static const MethodChannel _channel = const MethodChannel('geo_algorithm');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> getUnionPolygon(dynamic p1, List p2) async {
    List args = [p1, p2];
    if (Platform.isIOS) {
      String wkt = "POLYGON((";
      for (dynamic p in p1) {
        wkt += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt = wkt.substring(0, wkt.length - 1);
      wkt += "))";
      String wkt2 = "POLYGON((";
      for (dynamic p in p2) {
        wkt2 += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt2 = wkt2.substring(0, wkt2.length - 1);
      wkt2 += "))";
      args = [wkt, wkt2];
      String unionStr = await _channel.invokeMethod('getUnionPolygon', args);
      unionStr = unionStr
          .replaceAll("POLYGON ((", "")
          .replaceAll("))", "")
          .replaceAll("MULTI(", "")
          .replaceAll("((", "")
          .replaceAll(")", "");
      List union = [];
      for (String pointStr in unionStr.split(",")) {
        List point = pointStr.trim().split(" ");
        double p1 = double.parse(point[0]);
        double p2 = double.parse(point[1]);
        union.add([p1, p2]);
      }
      return union;
    } else {
      final dynamic union =
          await _channel.invokeMethod('getUnionPolygon', args);
      return union;
    }
  }

  static Future<dynamic> dissolvePolygon(dynamic p1, dynamic p2) async {
    if (Platform.isIOS) {
      String wkt = "POLYGON((";
      for (dynamic p in p1) {
        wkt += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt = wkt.substring(0, wkt.length - 1);
      wkt += "))";
      String wkt2 = "LINESTRING(";
      for (dynamic p in p2) {
        wkt2 += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt2 = wkt2.substring(0, wkt2.length - 1);
      wkt2 += ")";
      List args = [wkt, wkt2];
      String unionStr = await _channel.invokeMethod('dissolvePolygon', args);
      unionStr = unionStr
          .replaceAll("GEOMETRYCOLLECTION (POLYGON ((", "")
          .replaceAll(")),", "")
          .replaceAll("((", "")
          .replaceAll(")))", "");
      List polys = [];
      for (String polyStr in unionStr.split("POLYGON")) {
        List points = polyStr.trim().split(",");
        List poly = [];
        for (String pointStr in points) {
          List point = pointStr.trim().split(" ");
          double p1 = double.parse(point[0]);
          double p2 = double.parse(point[1]);
          poly.add([p1, p2]);
        }
        polys.add(poly);
      }
      return polys;
    } else {
      final dynamic polys =
          await _channel.invokeMethod('dissolvePolygon', [p1, p2]);
      return polys;
    }
  }

  static Future<bool> checkIntersects(
      dynamic p1, dynamic p2, bool isPolygon) async {
    if (Platform.isIOS) {
      List args = [];
      String wkt = "POLYGON((";
      for (dynamic p in p1) {
        wkt += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt = wkt.substring(0, wkt.length - 1);
      wkt += "))";
      String wkt2 = "POLYGON((";
      if (!isPolygon) {
        wkt2 = "LINESTRING((";
      }
      for (dynamic p in p2) {
        wkt2 += p[0].toString() + " " + p[1].toString() + ",";
      }
      wkt2 = wkt2.substring(0, wkt2.length - 1);
      wkt2 += "))";
      args = [wkt, wkt2];
      String unionStr = await _channel.invokeMethod('checkIntersects', args);
      return unionStr == 'true' ? true : false;
    } else {
      final bool isIntersects =
          await _channel.invokeMethod('dissolvePolygon', [p1, p2]);
      return isIntersects;
    }
  }
}
