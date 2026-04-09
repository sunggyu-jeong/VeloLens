cmake_minimum_required(VERSION 3.22.1)
project(velolens)

set(CMAKE_CXX_STANDARD 17)

set(PACKAGE_NAME "velolens")
set(NODE_MODULES_DIR "${CMAKE_SOURCE_DIR}/../../../../../node_modules")
set(RN_DIR "${NODE_MODULES_DIR}/react-native")

find_package(ReactAndroid REQUIRED CONFIG)
find_package(fbjni REQUIRED CONFIG)

add_library(
  ${PACKAGE_NAME}
  SHARED
  ${CMAKE_SOURCE_DIR}/../../../../../../cpp/VeloLensModule.cpp
  ${CMAKE_SOURCE_DIR}/../../../../../../cpp/FrameHostObject.cpp
  OnLoad.cpp
  FrameBridge.cpp
)

target_include_directories(
  ${PACKAGE_NAME}
  PRIVATE
  "${RN_DIR}/ReactAndroid/src/main/jni/react/turbomodule"
  "${RN_DIR}/ReactCommon"
  "${RN_DIR}/ReactCommon/jsi"
  "${RN_DIR}/ReactCommon/react/nativemodule/core"
  "${CMAKE_SOURCE_DIR}/../../../../../../cpp"
)

target_link_libraries(
  ${PACKAGE_NAME}
  ReactAndroid::jsi
  ReactAndroid::reactnativejni
  fbjni::fbjni
  android
  log
)
