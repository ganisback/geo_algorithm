#import "GeoAlgorithmPlugin.h"
#import <geo_algorithm/geo_algorithm-Swift.h>

@implementation GeoAlgorithmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGeoAlgorithmPlugin registerWithRegistrar:registrar];
}
@end
