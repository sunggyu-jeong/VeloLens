require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "VeloLensModule"
  s.version      = package["version"]
  s.summary      = "VeloLens JSI native module"
  s.homepage     = "https://github.com/sunggyu-jeong/VeloLens"
  s.license      = "MIT"
  s.authors      = { "sunggyu-jeong" => "sunggyu-jeong@github.com" }
  s.platforms    = { :ios => "13.4" }
  s.source       = { :git => "", :tag => "#{s.version}" }

  s.source_files = "cpp/**/*.{h,cpp}", "ios/Velo*.{h,mm}"

  s.dependency "React-Core"
  s.dependency "React-jsi"
  s.dependency "VisionCamera"

  s.pod_target_xcconfig = {
    "CLANG_CXX_LANGUAGE_STANDARD" => "c++17",
    "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/Headers/Public/React-jsi"
  }
end
