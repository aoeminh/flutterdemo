package com.example.flutter_app

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/// Main constructor to setup the Registrar
/// Private variable to hold instance of Registrar for creating Intents.
class AppSettingsPlugin( private var registrar: Registrar) : MethodCallHandler {

    final var wifiSetting = "wifi";
    final var appSetting = "app_settings";
    final var locationSetting = "location";
    final var securitySetting = "security";
    final var packages = "package";
    /// Private method to open device settings window
    private fun openSettings(url: String) {
        this.registrar.activity().startActivity(Intent(url))
    }

    companion object {

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "app_settings")
            channel.setMethodCallHandler(AppSettingsPlugin(registrar))
        }
    }

    /// Handler method to manage method channel calls.
    override fun onMethodCall(call: MethodCall, result: Result) {

        if (call.method == "wifi") {
            Log.d("ssssssss", "${call.arguments}")
            openSettings(android.provider.Settings.ACTION_WIFI_SETTINGS)

        } else if (call.method == "location") {
            openSettings(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS)
        } else if (call.method == "security") {
            openSettings(android.provider.Settings.ACTION_SECURITY_SETTINGS)
        } else if (call.method == "app_settings") {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            val uri = Uri.fromParts("package", this.registrar.activity().getPackageName(), null)
            intent.setData(uri)
            this.registrar.activity().startActivity(intent)
        }
    }
}