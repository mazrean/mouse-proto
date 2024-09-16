package com.mazrean.mouse_proto

import android.app.Activity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class EventChannelManager(private val activity: Activity, flutterEngine: FlutterEngine) {
    companion object {
        private const val EVENT_CHANNEL = "com.mazrean.mouse_proto/event"
    }

    private var eventSink: EventChannel.EventSink? = null

    init {
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            }
        )
    }

    fun log(log: String) {
        activity.runOnUiThread {
            eventSink?.success(log)
        }
    }
}