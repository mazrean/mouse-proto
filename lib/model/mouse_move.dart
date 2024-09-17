import 'package:freezed_annotation/freezed_annotation.dart';

part 'mouse_move.freezed.dart';

@freezed
class MouseMove with _$MouseMove {
  const factory MouseMove({
    required int x,
    required int y,
    required int wheel,
  }) = _MouseMove;
}
