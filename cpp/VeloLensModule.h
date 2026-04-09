#pragma once
#include <jsi/jsi.h>
#include "FrameHostObject.h"

namespace velolens {

using namespace facebook::jsi;

class VeloLensModule : public HostObject {
public:
  Value get(Runtime& rt, const PropNameID& name) override;
  void set(Runtime& rt, const PropNameID& name, const Value& value) override;
  std::vector<PropNameID> getPropertyNames(Runtime& rt) override;

  static void install(Runtime& rt);

  static Value makeFrameObject(Runtime& rt, FrameMetadata meta);
};

} // namespace velolens
