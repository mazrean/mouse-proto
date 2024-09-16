package com.mazrean.mouse_proto

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothGatt
import android.bluetooth.BluetoothGattCharacteristic
import android.bluetooth.BluetoothGattDescriptor
import android.bluetooth.BluetoothGattServer
import android.bluetooth.BluetoothGattServerCallback
import android.bluetooth.BluetoothGattService
import android.bluetooth.BluetoothManager
import android.bluetooth.le.AdvertiseCallback
import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.HexFormat
import java.util.UUID
import kotlin.system.exitProcess

class MainActivity: FlutterActivity() {
    companion object {
        private const val BLE_CHANNEL = "com.mazrean.mouse_proto/ble"
    }
    private lateinit var eventChannelManager: EventChannelManager
    private lateinit var bluetoothController: BluetoothController

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        eventChannelManager = EventChannelManager(this, flutterEngine)
        bluetoothController = BluetoothController(this, eventChannelManager)
        if (!bluetoothController.requestPermissions()) {
            exitProcess(1)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendMouse" -> {
                    val right = call.argument<Boolean>("right") ?: false
                    val left = call.argument<Boolean>("left") ?: false
                    val middle = call.argument<Boolean>("middle") ?: false
                    val x = call.argument<Int>("x") ?: 0
                    val y = call.argument<Int>("y") ?: 0
                    val wheel = call.argument<Int>("wheel") ?: 0
                    eventChannelManager.log("sendMouse: right=$right, left=$left, middle=$middle, x=$x, y=$y, wheel=$wheel")

                    bluetoothController.sendMouseReport(right, middle, left, x, y, wheel)

                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
