#include <fbjni/fbjni.h>
#include <jsi/jsi.h>
#include "VeloLensModule.h"

using namespace facebook;
using namespace velolens;

extern "C" {

JNIEXPORT jlong JNICALL
Java_com_velolens_VeloFrameProcessorPlugin_nativeGetDirectBufferAddress(
    JNIEnv* env, jobject, jobject buffer) {
  return (jlong)env->GetDirectBufferAddress(buffer);
}

JNIEXPORT jobject JNICALL
Java_com_velolens_VeloFrameProcessorPlugin_nativeMakeFrameObject(
    JNIEnv*, jobject,
    jlong jsiPtr,
    jint width, jint height, jint bytesPerRow,
    jlong timestamp, jlong dataPtr) {

  auto& rt = *reinterpret_cast<jsi::Runtime*>(jsiPtr);

  FrameMetadata meta = {
    .width       = (uint32_t)width,
    .height      = (uint32_t)height,
    .bytesPerRow = (uint32_t)bytesPerRow,
    .timestamp   = (uint64_t)timestamp,
    .dataPtr     = reinterpret_cast<const uint8_t*>(dataPtr),
  };

  auto frameObj = VeloLensModule::makeFrameObject(rt, meta);

  return nullptr;
}

} // extern "C"
