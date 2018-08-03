package com.xiaoyu.flutterapp

import android.os.Bundle
import android.widget.Toast
import com.xiaoyu.kratos.GeneratedPluginRegistrant
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "permission"
    private val REQUEST_PERMISSION = "requestPermission"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
            if(methodCall.method.equals("requestPermission")) {
                Toast.makeText(this, "toast", Toast.LENGTH_SHORT).show()
                result.success("good!")
            }
        }
    }

}
