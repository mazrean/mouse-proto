package com.mazrean.mouse_proto

import com.mazrean.mouse_proto.platform.BluetoothHIDApi
import com.mazrean.mouse_proto.platform.MouseMessage
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import kotlin.system.exitProcess

class MainActivity: FlutterActivity() {
    private lateinit var eventChannelManager: EventChannelManager
    private lateinit var bluetoothController: BluetoothController

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        eventChannelManager = EventChannelManager(this, flutterEngine)
        bluetoothController = BluetoothController(this)
        if (!bluetoothController.requestPermissions()) {
            exitProcess(1)
        }

        BluetoothHIDApi.setUp(flutterEngine.dartExecutor.binaryMessenger, object : BluetoothHIDApi {
            override fun sendMouseMessage(message: MouseMessage, callback: (Result<Unit>) -> Unit) {
                val result = bluetoothController.sendMouseReport(
                    message.right,
                    message.middle,
                    message.left,
                    message.x.toInt(),
                    message.y.toInt(),
                    message.wheel.toInt()
                )
                callback(result)
            }
        })
    }
}
