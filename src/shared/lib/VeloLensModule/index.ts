/* eslint-disable */
export interface FrameInfo {
  readonly width: number;
  readonly height: number;
  readonly bytesPerRow: number;
  readonly timestamp: number;
  readonly dataPointer: number;
}

interface VeloLensNative {
  ping(): string;
}

declare global {
  var __VeloLens: VeloLensNative | undefined;
}

export function getVeloLensModule(): VeloLensNative {
  const module = (global as any).__VeloLens;
  if (module === undefined || module === null) {
    throw new Error('VeloLens JSI module is not installed.');
  }
  return module;
}
