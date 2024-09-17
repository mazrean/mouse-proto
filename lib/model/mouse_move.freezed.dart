// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mouse_move.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MouseMove {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get wheel => throw _privateConstructorUsedError;

  /// Create a copy of MouseMove
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MouseMoveCopyWith<MouseMove> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MouseMoveCopyWith<$Res> {
  factory $MouseMoveCopyWith(MouseMove value, $Res Function(MouseMove) then) =
      _$MouseMoveCopyWithImpl<$Res, MouseMove>;
  @useResult
  $Res call({int x, int y, int wheel});
}

/// @nodoc
class _$MouseMoveCopyWithImpl<$Res, $Val extends MouseMove>
    implements $MouseMoveCopyWith<$Res> {
  _$MouseMoveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MouseMove
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? wheel = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$MouseMoveImplCopyWith<$Res>
    implements $MouseMoveCopyWith<$Res> {
  factory _$$MouseMoveImplCopyWith(
          _$MouseMoveImpl value, $Res Function(_$MouseMoveImpl) then) =
      __$$MouseMoveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y, int wheel});
}

/// @nodoc
class __$$MouseMoveImplCopyWithImpl<$Res>
    extends _$MouseMoveCopyWithImpl<$Res, _$MouseMoveImpl>
    implements _$$MouseMoveImplCopyWith<$Res> {
  __$$MouseMoveImplCopyWithImpl(
      _$MouseMoveImpl _value, $Res Function(_$MouseMoveImpl) _then)
      : super(_value, _then);

  /// Create a copy of MouseMove
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? wheel = null,
  }) {
    return _then(_$MouseMoveImpl(
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

class _$MouseMoveImpl implements _MouseMove {
  const _$MouseMoveImpl(
      {required this.x, required this.y, required this.wheel});

  @override
  final int x;
  @override
  final int y;
  @override
  final int wheel;

  @override
  String toString() {
    return 'MouseMove(x: $x, y: $y, wheel: $wheel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MouseMoveImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.wheel, wheel) || other.wheel == wheel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y, wheel);

  /// Create a copy of MouseMove
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MouseMoveImplCopyWith<_$MouseMoveImpl> get copyWith =>
      __$$MouseMoveImplCopyWithImpl<_$MouseMoveImpl>(this, _$identity);
}

abstract class _MouseMove implements MouseMove {
  const factory _MouseMove(
      {required final int x,
      required final int y,
      required final int wheel}) = _$MouseMoveImpl;

  @override
  int get x;
  @override
  int get y;
  @override
  int get wheel;

  /// Create a copy of MouseMove
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MouseMoveImplCopyWith<_$MouseMoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
