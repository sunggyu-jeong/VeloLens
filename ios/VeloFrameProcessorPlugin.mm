#import "VeloFrameProcessorPlugin.h"
#import <VisionCamera/Frame.h>
#import <CoreMedia/CMSampleBuffer.h>
#import <CoreVideo/CVPixelBuffer.h>
#import <jsi/jsi.h>
#include "VeloLensModule.h"

using namespace facebook::jsi;
using namespace velolens;

@implementation VeloFrameProcessorPlugin

- (instancetype)initWithProxy:(VisionCameraProxyHolder*)proxy
                  withOptions:(NSDictionary* _Nullable)options {
  self = [super initWithProxy:proxy withOptions:options];
  return self;
}

- (id _Nullable)callback:(Frame* _Nonnull)frame
           withArguments:(NSDictionary* _Nullable)arguments {
  CMSampleBufferRef sampleBuffer = frame.buffer;
  CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);

  CVPixelBufferLockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);

  FrameMetadata meta = {
    .width       = (uint32_t)CVPixelBufferGetWidth(pixelBuffer),
    .height      = (uint32_t)CVPixelBufferGetHeight(pixelBuffer),
    .bytesPerRow = (uint32_t)CVPixelBufferGetBytesPerRow(pixelBuffer),
    .timestamp   = (uint64_t)CMTimeGetSeconds(CMSampleBufferGetPresentationTimeStamp(sampleBuffer)) * 1000,
    .dataPtr     = (const uint8_t*)CVPixelBufferGetBaseAddress(pixelBuffer),
  };

  CVPixelBufferUnlockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);

  Runtime* runtime = [self.proxy runtime];
  if (!runtime) return nil;

  Value frameObj = VeloLensModule::makeFrameObject(*runtime, meta);

  return [self.proxy toNSObject:std::move(frameObj)];
}

VISION_EXPORT_FRAME_PROCESSOR(VeloFrameProcessorPlugin, getVeloFrame)

@end
