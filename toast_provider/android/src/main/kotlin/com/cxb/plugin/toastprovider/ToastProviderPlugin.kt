package com.cxb.plugin.toastprovider

import android.content.Context
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.widget.Toast

class ToastProviderPlugin(private val registrar: Registrar) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "toast_provider")
            channel.setMethodCallHandler(ToastProviderPlugin(registrar))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        val context = registrar.context()

        when (call.method) {
            "showToast" -> {
                val message = call.argument<String?>("message")
                if (message != null && message.isNotEmpty()) {
                    showToast(context, message, Toast.LENGTH_SHORT)
                    result.success(null)
                }
            }
            "showToastLong" -> {
                val message = call.argument<String?>("message")
                if (message != null && message.isNotEmpty()) {
                    showToast(context, message, Toast.LENGTH_LONG)
                    result.success(null)
                }
            }
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            else -> result.notImplemented()
        }
    }

    private fun showToast(context: Context, message: String, duration: Int) = Toast.makeText(context, message, duration).show()

}
