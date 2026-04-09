#import "VeloLensInstaller.h"
#import <React/RCTBridge+Private.h>
#import <jsi/jsi.h>
#include "VeloLensModule.h"

@implementation VeloLensInstaller

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (void)setBridge:(RCTBridge *)bridge {
  RCTCxxBridge *cxxBridge = (RCTCxxBridge *)bridge;
  if (!cxxBridge.runtime) return;

  velolens::VeloLensModule::install(*(facebook::jsi::Runtime *)cxxBridge.runtime);
}

@end
