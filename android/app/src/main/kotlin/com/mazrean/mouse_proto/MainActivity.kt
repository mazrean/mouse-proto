package com.mazrean.mouse_proto

import android.Manifest
import android.bluetooth.BluetoothManager
import android.bluetooth.le.AdvertiseCallback
import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class BluetoothUnavailable: Error("bluetooth is not available on this device")
class BluetoothAdvertisingPermissionRequired: Error("bluetooth advertising permission is required")

class MainActivity: FlutterActivity() {
    companion object {
        private const val BLE_CHANNEL = "com.mazrean.mouse_proto/peripheral"
        private const val EVENT_CHANNEL = "com.mazrean.mouse_proto/event"
        private const val PERMISSION_REQUEST_CODE = 101
    }
    var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startAdvertising" -> {
                    checkAndRequestBLEPermissions()
                    startAdvertising().getOrElse {
                        when(it) {
                            is BluetoothUnavailable ->
                                result.error("bluetooth_unavailable", it.message, it.stackTraceToString())
                            is BluetoothAdvertisingPermissionRequired ->
                                result.error("bluetooth_advertising_permission_required", it.message, it.stackTraceToString())
                            else ->
                                result.error("unknown_error", it.message, it.stackTraceToString())
                        }
                        return@setMethodCallHandler
                    }
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

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

    private fun checkAndRequestBLEPermissions() {
        val permissions = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            listOf(
                Manifest.permission.BLUETOOTH_SCAN,
                Manifest.permission.BLUETOOTH_ADVERTISE,
                Manifest.permission.BLUETOOTH_CONNECT
            )
        } else {
            listOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_ADMIN
            )
        }

        val requiresPermissions = permissions.filter {
            ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED
        }.toTypedArray()

        ActivityCompat.requestPermissions(this, requiresPermissions, PERMISSION_REQUEST_CODE)
    }

    private fun startAdvertising(): Result<Unit> {
        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager?
        val bluetoothLeAdvertiser = bluetoothManager?.adapter?.bluetoothLeAdvertiser
            ?: return Result.failure(BluetoothUnavailable())

        val settings = AdvertiseSettings.Builder()
            .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
            .setConnectable(true)
            .setTimeout(0)
            .build()

        val data = AdvertiseData.Builder()
            .setIncludeDeviceName(true)
            .build()

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE) != PackageManager.PERMISSION_GRANTED) {
            return Result.failure(BluetoothAdvertisingPermissionRequired())
        }
        bluetoothLeAdvertiser.startAdvertising(settings, data, object : AdvertiseCallback() {
            override fun onStartSuccess(settingsInEffect: AdvertiseSettings) {
                super.onStartSuccess(settingsInEffect)
                eventSink?.success("advertising started")
            }

            override fun onStartFailure(errorCode: Int) {
                super.onStartFailure(errorCode)
                eventSink?.error("advertising_failed", "error code: $errorCode", "error code: $errorCode")
            }
        })

        return Result.success(Unit)
    }
}
