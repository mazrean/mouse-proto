package com.mazrean.mouse_proto

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothHidDevice
import android.bluetooth.BluetoothHidDeviceAppQosSettings
import android.bluetooth.BluetoothHidDeviceAppSdpSettings
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.concurrent.Executors
import kotlin.experimental.or

class BluetoothPermissionRequired: Error("bluetooth permission is required")

@SuppressLint("MissingPermission")
class BluetoothController(private val activity: Activity, private val eventChannelManager: EventChannelManager) {
    companion object {
        private const val PERMISSION_REQUEST_CODE = 101
        private const val MOUSE_REPORT_ID = 0x1

        private val REPORT_MAP = byteArrayOf(
            0x05, 0x01,  // Usage Page (Generic Desktop)
            0x09, 0x02,  // Usage (Mouse)
            0xA1.toByte(), 0x01,  // Collection (Application)
            0x85.toByte(), MOUSE_REPORT_ID.toByte(),  //   Report ID (1)
            0x09, 0x01,  //   Usage (Pointer)
            0xA1.toByte(), 0x00,  //   Collection (Physical)
            0x05, 0x09,  //     Usage Page (Button)
            0x19, 0x01,  //     Usage Minimum (1)
            0x29, 0x03,  //     Usage Maximum (3)
            0x15, 0x00,  //     Logical Minimum (0)
            0x25, 0x01,  //     Logical Maximum (1)
            0x95.toByte(), 0x03,  //     Report Count (3)
            0x75, 0x01,  //     Report Size (1)
            0x81.toByte(), 0x02,  //     Input (Data,Var,Abs)
            0x95.toByte(), 0x01,  //     Report Count (1)
            0x75, 0x05,  //     Report Size (5)
            0x81.toByte(), 0x03,  //     Input (Cnst,Var,Abs)
            0x05, 0x01,  //     Usage Page (Generic Desktop)
            0x09, 0x30,  //     Usage (X)
            0x09, 0x31,  //     Usage (Y)
            0x15, 0x81.toByte(),  //     Logical Minimum (-127)
            0x25, 0x7F,  //     Logical Maximum (127)
            0x75, 0x08,  //     Report Size (8)
            0x95.toByte(), 0x02,  //     Report Count (2)
            0x81.toByte(), 0x06,  //     Input (Data,Var,Rel)
            0x09, 0x38,  //     Usage (Wheel)
            0x15, 0x81.toByte(),  //     Logical Minimum (-127)
            0x25, 0x7f,  //     Logical Maximum (127)
            0x75, 0x08,  //     Report Size (8)
            0x95.toByte(), 0x01,  //     Report Count (1)
            0x81.toByte(), 0x06,  //     Input (Data,Var,Rel)
            0xC0.toByte(),        //   End Collection
            0xC0.toByte()         // End Collection
        )

        private val SDP_RECORD = BluetoothHidDeviceAppSdpSettings(
            "Mouse Input",
            "HID Device",
            "Android",
            BluetoothHidDevice.SUBCLASS1_MOUSE,
            REPORT_MAP
        )

        private val QOS_OUT = BluetoothHidDeviceAppQosSettings(
            BluetoothHidDeviceAppQosSettings.SERVICE_BEST_EFFORT,
            800,
            9,
            0,
            11250,
            BluetoothHidDeviceAppQosSettings.MAX
        )

        private val PERMISSIONS = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            arrayOf(Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_CONNECT)
        } else {
            arrayOf(Manifest.permission.BLUETOOTH, Manifest.permission.BLUETOOTH_ADMIN)
        }
    }

    private val bluetoothManager: BluetoothManager = activity.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
    private val bluetoothAdapter: BluetoothAdapter? by lazy { bluetoothManager.adapter }

    @Volatile
    private var hidDevice: BluetoothHidDevice? = null

    init {
        if (bluetoothAdapter == null) {
            throw BluetoothPermissionRequired()
        }

        CoroutineScope(Dispatchers.IO).launch {
            register()
        }
    }

    fun requestPermissions(): Boolean {
        val requiredPermissions = PERMISSIONS.filter {
            ContextCompat.checkSelfPermission(activity, it) != PackageManager.PERMISSION_GRANTED
        }
        if (requiredPermissions.isEmpty()) return true

        ActivityCompat.requestPermissions(activity, PERMISSIONS, PERMISSION_REQUEST_CODE)

        return PERMISSIONS.all {
            ContextCompat.checkSelfPermission(activity, it) == PackageManager.PERMISSION_GRANTED
        }
    }

    private val serviceListener = object : BluetoothProfile.ServiceListener {
        override fun onServiceConnected(profile: Int, proxy: BluetoothProfile) {
            eventChannelManager.log("onServiceConnected")

            hidDevice = proxy as? BluetoothHidDevice

            hidDevice?.registerApp(
                SDP_RECORD,
                null,
                QOS_OUT,
                Executors.newCachedThreadPool(),
                object : BluetoothHidDevice.Callback() {}
            )
        }

        override fun onServiceDisconnected(profile: Int) {
            eventChannelManager.log("onServiceDisconnected")

            hidDevice = null
        }
    }

    private fun register(): Boolean {
        if (hidDevice != null) {
            unregister()
        }

        return bluetoothAdapter?.getProfileProxy(
            activity,
            serviceListener,
            BluetoothProfile.HID_DEVICE
        ) ?: false
    }

    private fun unregister() {
        hidDevice?.unregisterApp()
        bluetoothAdapter?.closeProfileProxy(BluetoothProfile.HID_DEVICE, hidDevice)

        hidDevice = null
    }

    fun sendMouseReport(
        right: Boolean, middle: Boolean, left: Boolean,
        x: Int, y: Int,
        wheel: Int) {
        val report = ByteArray(4)

        if (right) report[0] = report[0] or 0x01
        if (middle) report[0] = report[0] or 0x04
        if (left) report[0] = report[0] or 0x02

        report[1] = x.toByte()
        report[2] = y.toByte()

        report[3] = wheel.toByte()

        sendReport(report)
    }

    private fun sendReport(report: ByteArray) {
        if (hidDevice == null) {
            eventChannelManager.log("BluetoothHidDevice is null")
            return
        }

        hidDevice?.getDevicesMatchingConnectionStates(intArrayOf(BluetoothProfile.STATE_CONNECTED))?.forEach {
            eventChannelManager.log("Sending report to $it")
            hidDevice?.sendReport(it, MOUSE_REPORT_ID, report)
        }
    }
}