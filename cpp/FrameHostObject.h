#pragma once
#include <jsi/jsi.h>
#include <cstdint>

namespace velolens {

using namespace facebook::jsi;

struct FrameMetadata {
  uint32_t width;
  uint32_t height;
  uint32_t bytesPerRow;
  uint64_t timestamp;
  const uint8_t* dataPtr;
};

class FrameHostObject : public HostObject {
public:
  explicit FrameHostObject(FrameMetadata meta) : meta_(meta) {}

  Value get(Runtime& rt, const PropNameID& name) override;
  void set(Runtime& rt, const PropNameID& name, const Value& value) override;
  std::vector<PropNameID> getPropertyNames(Runtime& rt) override;

private:
  FrameMetadata meta_;
};

} // namespace velolens
