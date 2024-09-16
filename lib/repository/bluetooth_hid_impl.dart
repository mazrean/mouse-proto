import 'package:flutter/services.dart';
import 'package:mouse_proto/model/mouse_state.dart';
import 'package:mouse_proto/repository/bluetooth_hid.dart';

class BluetoothHIDImpl extends BluetoothHID {
  final _platform = const MethodChannel('com.mazrean.mouse_proto/ble');
  final _eventChannel = const EventChannel('com.mazrean.mouse_proto/event');

  BluetoothHIDImpl._();

  static Future<BluetoothHIDImpl> create() async {
    var bluetoothHID = BluetoothHIDImpl._();

    bluetoothHID._eventChannel.receiveBroadcastStream().listen((event) {
      print('Received event: $event');
    });

    return BluetoothHIDImpl._();
  }

  @override
  sendMouseState(MouseState state) {
    _platform.invokeMethod('sendMouse', {
      'left': state.leftButton,
      'right': state.rightButton,
      'middle': state.middleButton,
      'x': _roundToSignedByte(state.x),
      'y': _roundToSignedByte(state.y),
      'wheel': _roundToSignedByte(state.wheel),
    });
  }

  static List<int> _roundToSignedBytes(int value) {
    switch (value) {
      case >127:
        value = 127;
      case <-127:
        value = -127;
    }

    return [value & 0xFF];
  }

  static int _roundToSignedByte(int value) {
    switch (value) {
      case >127:
        value = 127;
      case <-127:
        value = -127;
    }

    return value & 0xFF;
  }
}