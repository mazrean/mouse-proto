import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_proto/model/mouse_state.dart';

import 'package:mouse_proto/repository/bluetooth_hid.dart';

final mouseStateViewModelProvider = StateNotifierProvider.autoDispose<MouseStateViewModel, MouseState>(
  (ref) => MouseStateViewModel(
    const MouseState(
      leftButton: false,
      rightButton: false,
      middleButton: false,
      x: 0,
      y: 0,
      wheel: 0,
    ),
  ),
);

class MouseStateViewModel extends StateNotifier<MouseState> {
  MouseStateViewModel(super.state);

  final _bluetoothHID = BluetoothHID.create();

  void setButtonState(MouseButton button, bool isDown) {
    state = state.setButtonState(button, isDown);
    _bluetoothHID.then((hid) {
      hid.sendMouseState(state);
    });
  }

  void setPointerPosition(int x, int y) {
    state = state.setPointerPosition(x, y);
    _bluetoothHID.then((hid) {
      hid.sendMouseState(state);
    });
  }

  void setWheel(int wheel) {
    state = state.setWheel(wheel);
    _bluetoothHID.then((hid) {
      hid.sendMouseState(state);
    });
  }
}
