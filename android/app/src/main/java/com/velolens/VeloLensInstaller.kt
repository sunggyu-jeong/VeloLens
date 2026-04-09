package com.velolens

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class VeloLensInstaller(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName() = "VeloLensInstaller"

    override fun initialize() {
        super.initialize()
        val jsContext = reactApplicationContext.javaScriptContextHolder?.get() ?: return
        nativeInstall(jsContext)
    }

    companion object {
        init {
            System.loadLibrary("velolens")
        }
    }

    private external fun nativeInstall(jsiPtr: Long)
}
