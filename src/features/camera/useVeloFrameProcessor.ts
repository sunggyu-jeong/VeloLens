import { useSharedValue, type SharedValue } from 'react-native-reanimated';
import { useFrameProcessor } from 'react-native-vision-camera';
import type { FrameProcessor } from 'react-native-vision-camera';

import type { FrameInfo } from '../../shared/lib/VeloLensModule';

declare function getVeloFrame(frame: unknown): FrameInfo;

interface VeloFrameProcessorResult {
  frameProcessor: FrameProcessor;
  frameWidth: SharedValue<number>;
  frameHeight: SharedValue<number>;
}

export function useVeloFrameProcessor(): VeloFrameProcessorResult {
  const frameWidth = useSharedValue(0);
  const frameHeight = useSharedValue(0);

  const frameProcessor = useFrameProcessor(
    (frame) => {
      'worklet';

      const info = getVeloFrame(frame);
      frameWidth.value = info.width;
      frameHeight.value = info.height;
    },
    [frameWidth, frameHeight],
  );

  return { frameProcessor, frameWidth, frameHeight };
}
