#include "FrameHostObject.h"

namespace velolens {

Value FrameHostObject::get(Runtime& rt, const PropNameID& name) {
  auto prop = name.utf8(rt);

  if (prop == "width")       return Value((int)meta_.width);
  if (prop == "height")      return Value((int)meta_.height);
  if (prop == "bytesPerRow") return Value((int)meta_.bytesPerRow);
  if (prop == "timestamp")   return Value((double)meta_.timestamp);

  if (prop == "dataPointer") {
    return Value((double)(uintptr_t)meta_.dataPtr);
  }

  return Value::undefined();
}

void FrameHostObject::set(Runtime&, const PropNameID&, const Value&) {}

std::vector<PropNameID> FrameHostObject::getPropertyNames(Runtime& rt) {
  std::vector<PropNameID> props;
  props.emplace_back(PropNameID::forAscii(rt, "width"));
  props.emplace_back(PropNameID::forAscii(rt, "height"));
  props.emplace_back(PropNameID::forAscii(rt, "bytesPerRow"));
  props.emplace_back(PropNameID::forAscii(rt, "timestamp"));
  props.emplace_back(PropNameID::forAscii(rt, "dataPointer"));
  return props;
}

} // namespace velolens
