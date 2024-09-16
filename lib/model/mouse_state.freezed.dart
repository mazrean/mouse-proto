// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mouse_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MouseState {
  bool get leftButton => throw _privateConstructorUsedError;
  bool get rightButton => throw _privateConstructorUsedError;
  bool get middleButton => throw _privateConstructorUsedError;
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get wheel => throw _privateConstructorUsedError;

  /// Create a copy of MouseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MouseStateCopyWith<MouseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MouseStateCopyWith<$Res> {
  factory $MouseStateCopyWith(
          MouseState value, $Res Function(MouseState) then) =
      _$MouseStateCopyWithImpl<$Res, MouseState>;
  @useResult
  $Res call(
      {bool leftButton,
      bool rightButton,
      bool middleButton,
      int x,
      int y,
      int wheel});
}

/// @nodoc
class _$MouseStateCopyWithImpl<$Res, $Val extends MouseState>
    implements $MouseStateCopyWith<$Res> {
  _$MouseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MouseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leftButton = null,
    Object? rightButton = null,
    Object? middleButton = null,
    Object? x = null,
    Object? y = null,
    Object? wheel = null,
  }) {
    return _then(_value.copyWith(
      leftButton: null == leftButton
          ? _value.leftButton
          : leftButton // ignore: cast_nullable_to_non_nullable
              as bool,
      rightButton: null == rightButton
          ? _value.rightButton
          : rightButton // ignore: cast_nullable_to_non_nullable
              as bool,
      middleButton: null == middleButton
          ? _value.middleButton
          : middleButton // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      wheel: null == wheel
          ? _value.wheel
          : wheel // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MouseStateImplCopyWith<$Res>
    implements $MouseStateCopyWith<$Res> {
  factory _$$MouseStateImplCopyWith(
          _$MouseStateImpl value, $Res Function(_$MouseStateImpl) then) =
      __$$MouseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool leftButton,
      bool rightButton,
      bool middleButton,
      int x,
      int y,
      int wheel});
}

/// @nodoc
class __$$MouseStateImplCopyWithImpl<$Res>
    extends _$MouseStateCopyWithImpl<$Res, _$MouseStateImpl>
    implements _$$MouseStateImplCopyWith<$Res> {
  __$$MouseStateImplCopyWithImpl(
      _$MouseStateImpl _value, $Res Function(_$MouseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MouseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leftButton = null,
    Object? rightButton = null,
    Object? middleButton = null,
    Object? x = null,
    Object? y = null,
    Object? wheel = null,
  }) {
    return _then(_$MouseStateImpl(
      leftButton: null == leftButton
          ? _value.leftButton
          : leftButton // ignore: cast_nullable_to_non_nullable
              as bool,
      rightButton: null == rightButton
          ? _value.rightButton
          : rightButton // ignore: cast_nullable_to_non_nullable
              as bool,
      middleButton: null == middleButton
          ? _value.middleButton
          : middleButton // ignore: cast_nullable_to_non_nullable
              as bool,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      wheel: null == wheel
          ? _value.wheel
          : wheel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MouseStateImpl extends _MouseState {
  const _$MouseStateImpl(
      {required this.leftButton,
      required this.rightButton,
      required this.middleButton,
      required this.x,
      required this.y,
      required this.wheel})
      : super._();

  @override
  final bool leftButton;
  @override
  final bool rightButton;
  @override
  final bool middleButton;
  @override
  final int x;
  @override
  final int y;
  @override
  final int wheel;

  @override
  String toString() {
    return 'MouseState(leftButton: $leftButton, rightButton: $rightButton, middleButton: $middleButton, x: $x, y: $y, wheel: $wheel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MouseStateImpl &&
            (identical(other.leftButton, leftButton) ||
                other.leftButton == leftButton) &&
            (identical(other.rightButton, rightButton) ||
                other.rightButton == rightButton) &&
            (identical(other.middleButton, middleButton) ||
                other.middleButton == middleButton) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.wheel, wheel) || other.wheel == wheel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, leftButton, rightButton, middleButton, x, y, wheel);

  /// Create a copy of MouseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MouseStateImplCopyWith<_$MouseStateImpl> get copyWith =>
      __$$MouseStateImplCopyWithImpl<_$MouseStateImpl>(this, _$identity);
}

abstract class _MouseState extends MouseState {
  const factory _MouseState(
      {required final bool leftButton,
      required final bool rightButton,
      required final bool middleButton,
      required final int x,
      required final int y,
      required final int wheel}) = _$MouseStateImpl;
  const _MouseState._() : super._();

  @override
  bool get leftButton;
  @override
  bool get rightButton;
  @override
  bool get middleButton;
  @override
  int get x;
  @override
  int get y;
  @override
  int get wheel;

  /// Create a copy of MouseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MouseStateImplCopyWith<_$MouseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}