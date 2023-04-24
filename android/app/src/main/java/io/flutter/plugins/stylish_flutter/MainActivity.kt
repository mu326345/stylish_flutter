package io.flutter.plugins.stylish_flutter

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.stylish_flutter/getPlatformData"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getPlatformData") {
                val dataStr = getPlatformData()

                if (dataStr.isNotBlank()) {
                    result.success(dataStr)
                } else {
                    result.error("UNAVAILABLE", "android data fail!", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getPlatformData(): String {
        return "this is from android string"
    }
}
