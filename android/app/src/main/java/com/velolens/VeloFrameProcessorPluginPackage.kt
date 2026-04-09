package com.velolens

import com.mrousavy.camera.frameprocessors.FrameProcessorPlugin
import com.mrousavy.camera.frameprocessors.FrameProcessorPluginRegistry
import com.mrousavy.camera.frameprocessors.VisionCameraProxy

class VeloFrameProcessorPluginPackage : FrameProcessorPluginRegistry.FrameProcessorPluginProvider {
    override fun createFrameProcessorPlugin(
        proxy: VisionCameraProxy,
        name: String,
        options: Map<String, Any>?
    ): FrameProcessorPlugin? {
        if (name == "getVeloFrame") return VeloFrameProcessorPlugin(proxy, options)
        return null
    }
}
