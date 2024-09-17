import 'package:mouse_proto/model/mouse_move.dart';
import 'package:mouse_proto/model/mouse_state.dart';

import 'bluetooth_hid_impl.dart';

abstract class BluetoothHID {
  sendMouseMessage(MouseState state, MouseMove move);

  static Future<BluetoothHID> create() async {
    return await BluetoothHIDImpl.create();
  }
}
