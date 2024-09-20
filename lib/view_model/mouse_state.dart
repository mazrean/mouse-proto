import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mouse_proto/model/mouse_state.dart';
import 'package:mouse_proto/repository/bluetooth_hid.dart';
import 'package:mouse_proto/model/mouse_move.dart';

final mouseStateViewModelProvider = StateNotifierProvider.autoDispose<MouseStateViewModel, MouseState>(
  (ref) => MouseStateViewModel(
    const MouseState(
      leftButton: false,
      rightButton: false,
      middleButton: false,
    ),
  ),
);

class MouseStateViewModel extends StateNotifier<MouseState> {
  MouseStateViewModel(super.state);

  final _bluetoothHID = BluetoothHID.create();

  void setButtonState(MouseButton button, bool isDown) {
    state = state.setButtonState(button, isDown);
    _bluetoothHID.then((hid) {
      hid.sendMouseMessage(state, const MouseMove(x: 0, y: 0, wheel: 0));
    });
  }

  void clearButtonState() {
    state = state.clearButtonState();
    _bluetoothHID.then((hid) {
      hid.sendMouseMessage(state, const MouseMove(x: 0, y: 0, wheel: 0));
    });
  }

  void movePointer(int x, int y) {
    if (x == 0 && y == 0) return;

    _bluetoothHID.then((hid) {
      hid.sendMouseMessage(state, MouseMove(x: x, y: y, wheel: 0));
    });
  }

  void moveWheel(int wheel) {
    if (wheel == 0) return;

    _bluetoothHID.then((hid) {
      hid.sendMouseMessage(state, MouseMove(x: 0, y: 0, wheel: wheel));
    });
  }
}
