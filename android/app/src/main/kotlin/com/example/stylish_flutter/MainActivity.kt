package com.example.stylish_flutter

import android.app.AlertDialog
import android.content.ContextWrapper
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
            if (call.method == "tappay") {
                Log.d("QAQ", "go tappay")
//                val contextWrapper = ContextWrapper(context)
//                contextWrapper.setTheme(R.style.PaymentColorTheme)
                val dialog = PrimeDialog(context, object : PrimeDialog.PrimeDialogListener {
                    override fun onSuccess(prime: String) {
                        Log.v("QAQ", "onSuccess, prime=$prime")
                        result.success(prime)
                    }

                    override fun onFailure(error: String) {
                        Log.v("QAQ", "onFailure, error=$error")
                        result.success(error)
                    }
                })
                dialog.show()
            } else {
                result.error("404", "404", null)
            }
        }
    }
}
