package com.velolens

import android.graphics.ImageFormat
import androidx.camera.core.ImageProxy
import com.mrousavy.camera.frameprocessors.Frame
import com.mrousavy.camera.frameprocessors.FrameProcessorPlugin
import com.mrousavy.camera.frameprocessors.VisionCameraProxy

class VeloFrameProcessorPlugin(proxy: VisionCameraProxy, options: Map<String, Any>?) :
    FrameProcessorPlugin(proxy, options) {

    override fun callback(frame: Frame, arguments: Map<String, Any>?): Any? {
        val image: ImageProxy = frame.image

        val width = image.width
        val height = image.height
        val bytesPerRow = if (image.planes.isNotEmpty()) image.planes[0].rowStride else width * 4
        val timestamp = image.imageInfo.timestamp

        val dataPtr: Long = if (image.planes.isNotEmpty()) {
            val buffer = image.planes[0].buffer
            if (buffer.isDirect) {
                nativeGetDirectBufferAddress(buffer)
            } else 0L
        } else 0L

        return nativeMakeFrameObject(
            proxy.jsiRuntime,
            width,
            height,
            bytesPerRow,
            timestamp,
            dataPtr
        )
    }

    private external fun nativeGetDirectBufferAddress(buffer: java.nio.ByteBuffer): Long
    private external fun nativeMakeFrameObject(
        jsiRuntime: Long,
        width: Int,
        height: Int,
        bytesPerRow: Int,
        timestamp: Long,
        dataPtr: Long
    ): Any?

    companion object {
        init {
            System.loadLibrary("velolens")
        }
    }
}
