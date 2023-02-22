package com.example.ftts_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import com.skt.Tmap.*
import com.skt.Tmap.TMapTapi
import com.skt.Tmap.TMapView
import android.view.ViewGroup
import java.util.ArrayList
import android.content.Intent
import android.net.Uri

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.ftts_flutter/android"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if(call.method == "exeTMap") {
                    var res = exeTMap(call.arguments.toString())
                    result.success(res)
                }
            }
    }

    private fun exeTMap(arg: String): String {
        val tmaptapi = TMapTapi(this)
        tmaptapi.setSKTMapAuthentication("OEItraQcVU3jhMZpA1wTu3NCvh30OSHM2NBnu53b")
        // wait a second
        try {
            Thread.sleep(1000)
        } catch (e: InterruptedException) {
            e.printStackTrace()
        }

        if(tmaptapi.isTmapApplicationInstalled() == false) {
            var result = ""
            var urls = tmaptapi.getTMapDownUrl();
            if(urls != null) {
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(urls[0]))
                startActivity(intent)
            }
        }

        tmaptapi.invokeSearchPortal(arg)

        return "good"
    }
}