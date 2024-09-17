import 'package:freezed_annotation/freezed_annotation.dart';

part 'mouse_state.freezed.dart';

enum MouseButton {
  left,
  right,
  middle,
}

@freezed
class MouseState with _$MouseState {
  const MouseState._();
  const factory MouseState({
    required bool leftButton,
    required bool rightButton,
    required bool middleButton,
  }) = _MouseState;

  MouseState setButtonState(MouseButton button, bool isDown) {
    return switch (button) {
      MouseButton.left => copyWith(leftButton: isDown),
      MouseButton.right => copyWith(rightButton: isDown),
      MouseButton.middle => copyWith(middleButton: isDown),
    };
  }
}
