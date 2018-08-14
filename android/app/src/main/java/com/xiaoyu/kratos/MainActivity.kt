package com.xiaoyu.flutterapp

import android.os.Bundle
import android.widget.Toast
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val CHANNEL = "toast"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            if(methodCall.method.equals("makeToast")) {
                Toast.makeText(this, "toast", Toast.LENGTH_SHORT).show()
                result.success("good!")
            }
        }
    }

}
