package com.betagis.mapplugin.geoalgorithm;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** GeoAlgorithmPlugin */
public class GeoAlgorithmPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "geo_algorithm");
    channel.setMethodCallHandler(new GeoAlgorithmPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("getUnionPolygon")) {

      List args = (List)call.arguments;
      ArrayList<List<Double>> args0 = (ArrayList<List<Double>>) args.get(0);
      ArrayList<List<Double>> args1 = (ArrayList<List<Double>>) args.get(1);
      result.success(GeoUtil.getUnion(args0,args1));
    } else if (call.method.equals("dissolvePolygon")) {

      List args = (List)call.arguments;
      ArrayList<List<Double>> args0 = (ArrayList<List<Double>>) args.get(0);
      ArrayList<List<Double>> args1 = (ArrayList<List<Double>>) args.get(1);
      result.success(GeoUtil.getDissolvePolygon(args0,args1));
    } else {
      result.notImplemented();
    }
  }
}
