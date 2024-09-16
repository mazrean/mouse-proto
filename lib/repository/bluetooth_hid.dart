import 'package:mouse_proto/model/mouse_state.dart';

import 'bluetooth_hid_impl.dart';

abstract class BluetoothHID {
  sendMouseState(MouseState state);

  static Future<BluetoothHID> create() async {
    return await BluetoothHIDImpl.create();
  }
}
