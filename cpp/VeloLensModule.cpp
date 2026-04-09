#include "VeloLensModule.h"

namespace velolens {

Value VeloLensModule::get(Runtime& rt, const PropNameID& name) {
  auto prop = name.utf8(rt);

  if (prop == "ping") {
    return Function::createFromHostFunction(
        rt, PropNameID::forAscii(rt, "ping"), 0,
        [](Runtime& rt, const Value&, const Value*, size_t) -> Value {
          return String::createFromAscii(rt, "pong");
        });
  }

  return Value::undefined();
}

void VeloLensModule::set(Runtime&, const PropNameID&, const Value&) {}

std::vector<PropNameID> VeloLensModule::getPropertyNames(Runtime& rt) {
  return {
    PropNameID::forAscii(rt, "ping"),
  };
}

Value VeloLensModule::makeFrameObject(Runtime& rt, FrameMetadata meta) {
  auto hostObject = std::make_shared<FrameHostObject>(meta);
  return Object::createFromHostObject(rt, hostObject);
}

void VeloLensModule::install(Runtime& rt) {
  auto module = std::make_shared<VeloLensModule>();
  auto jsiObject = Object::createFromHostObject(rt, module);
  rt.global().setProperty(rt, "__VeloLens", std::move(jsiObject));
}

} // namespace velolens
