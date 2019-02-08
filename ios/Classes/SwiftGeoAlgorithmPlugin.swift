import Flutter
import UIKit
import GEOSwift
import MapKit

public class SwiftGeoAlgorithmPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "geo_algorithm", binaryMessenger: registrar.messenger())
    let instance = SwiftGeoAlgorithmPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getUnionPolygon"){
        let wkt: Array<String>? = call.arguments as? Array;
        let polygon1 = Geometry.create((wkt?[0])!);
        let polygon2 = Geometry.create((wkt?[1])!);
        let newpolygon = polygon1?.union(polygon2!);
        result(newpolygon?.WKT);
        return;
    }else if(call.method == "dissolvePolygon"){
        let wkt: Array<String>? = call.arguments as? Array;
        let polygon1 = Geometry.create((wkt?[0])!);
        let line2 = Geometry.create((wkt?[1])!);
        let polys = polygon1?.union(line2!);
        //polys?.intersects(T##geometry: Geometry##Geometry)
        print(polygon1?.WKT);
        print(polys?.WKT);
        return;
    }else if(call.method == "checkIntersects"){
        let wkt: Array<String>? = call.arguments as? Array;
        let polygon1 = Geometry.create((wkt?[0])!);
        let block2 = Geometry.create((wkt?[1])!);
        result(polygon1?.intersects(block2!));
        return;
    }
  }
}
