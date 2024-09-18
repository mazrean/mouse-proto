import 'package:flutter/services.dart';
import 'package:mouse_proto/model/mouse_state.dart';
import 'package:mouse_proto/repository/bluetooth_hid.dart';
import 'package:mouse_proto/model/mouse_move.dart';
import 'package:mouse_proto/repository/platform/bluetooth_hid.g.dart';

class BluetoothHIDImpl extends BluetoothHID {
  final _api = BluetoothHIDApi();
  final _eventChannel = const EventChannel('com.mazrean.mouse_proto/event');

  BluetoothHIDImpl._();
  static Future<BluetoothHIDImpl> create() async {
    var bluetoothHID = BluetoothHIDImpl._();

    bluetoothHID._eventChannel.receiveBroadcastStream().listen((event) {
      print('Received event: $event');
    });

    return bluetoothHID;
  }

  @override
  sendMouseMessage(MouseState state, MouseMove move) {
    _api.sendMouseMessage(MouseMessage(
      left: state.leftButton,
      right: state.rightButton,
      middle: state.middleButton,
      x: move.x,
      y: move.y,
      wheel: move.wheel,
    ));
  }
}