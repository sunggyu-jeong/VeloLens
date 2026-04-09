#include <fbjni/fbjni.h>
#include <jsi/jsi.h>
#include <ReactCommon/CallInvokerHolder.h>
#include "VeloLensModule.h"

using namespace facebook;

struct VeloLensInstaller : jni::JavaClass<VeloLensInstaller> {
  static constexpr auto kJavaDescriptor = "Lcom/velolens/VeloLensInstaller;";

  static void registerNatives() {
    registerHybrid({makeNativeMethod("nativeInstall", VeloLensInstaller::nativeInstall)});
  }

  static void nativeInstall(jni::alias_ref<jni::JClass>, jlong jsiPtr) {
    auto &rt = *reinterpret_cast<jsi::Runtime *>(jsiPtr);
    velolens::VeloLensModule::install(rt);
  }
};

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *) {
  return jni::initialize(vm, [] { VeloLensInstaller::registerNatives(); });
}
