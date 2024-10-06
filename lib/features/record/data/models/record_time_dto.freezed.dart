// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_time_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecordTimeDTO _$RecordTimeDTOFromJson(Map<String, dynamic> json) {
  return _RecordTimeDTO.fromJson(json);
}

/// @nodoc
mixin _$RecordTimeDTO {
// required String id,
  String get taskId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get recordTime => throw _privateConstructorUsedError;
  String? get contents => throw _privateConstructorUsedError;

  /// Serializes this RecordTimeDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordTimeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordTimeDTOCopyWith<RecordTimeDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordTimeDTOCopyWith<$Res> {
  factory $RecordTimeDTOCopyWith(
          RecordTimeDTO value, $Res Function(RecordTimeDTO) then) =
      _$RecordTimeDTOCopyWithImpl<$Res, RecordTimeDTO>;
  @useResult
  $Res call({String taskId, String date, int recordTime, String? contents});
}

/// @nodoc
class _$RecordTimeDTOCopyWithImpl<$Res, $Val extends RecordTimeDTO>
    implements $RecordTimeDTOCopyWith<$Res> {
  _$RecordTimeDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordTimeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? date = null,
    Object? recordTime = null,
    Object? contents = freezed,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      recordTime: null == recordTime
          ? _value.recordTime
          : recordTime // ignore: cast_nullable_to_non_nullable
              as int,
      contents: freezed == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordTimeDTOImplCopyWith<$Res>
    implements $RecordTimeDTOCopyWith<$Res> {
  factory _$$RecordTimeDTOImplCopyWith(
          _$RecordTimeDTOImpl value, $Res Function(_$RecordTimeDTOImpl) then) =
      __$$RecordTimeDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String taskId, String date, int recordTime, String? contents});
}

/// @nodoc
class __$$RecordTimeDTOImplCopyWithImpl<$Res>
    extends _$RecordTimeDTOCopyWithImpl<$Res, _$RecordTimeDTOImpl>
    implements _$$RecordTimeDTOImplCopyWith<$Res> {
  __$$RecordTimeDTOImplCopyWithImpl(
      _$RecordTimeDTOImpl _value, $Res Function(_$RecordTimeDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordTimeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? date = null,
    Object? recordTime = null,
    Object? contents = freezed,
  }) {
    return _then(_$RecordTimeDTOImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      recordTime: null == recordTime
          ? _value.recordTime
          : recordTime // ignore: cast_nullable_to_non_nullable
              as int,
      contents: freezed == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordTimeDTOImpl implements _RecordTimeDTO {
  const _$RecordTimeDTOImpl(
      {required this.taskId,
      required this.date,
      required this.recordTime,
      this.contents});

  factory _$RecordTimeDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordTimeDTOImplFromJson(json);

// required String id,
  @override
  final String taskId;
  @override
  final String date;
  @override
  final int recordTime;
  @override
  final String? contents;

  @override
  String toString() {
    return 'RecordTimeDTO(taskId: $taskId, date: $date, recordTime: $recordTime, contents: $contents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordTimeDTOImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.recordTime, recordTime) ||
                other.recordTime == recordTime) &&
            (identical(other.contents, contents) ||
                other.contents == contents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, taskId, date, recordTime, contents);

  /// Create a copy of RecordTimeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordTimeDTOImplCopyWith<_$RecordTimeDTOImpl> get copyWith =>
      __$$RecordTimeDTOImplCopyWithImpl<_$RecordTimeDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordTimeDTOImplToJson(
      this,
    );
  }
}

abstract class _RecordTimeDTO implements RecordTimeDTO {
  const factory _RecordTimeDTO(
      {required final String taskId,
      required final String date,
      required final int recordTime,
      final String? contents}) = _$RecordTimeDTOImpl;

  factory _RecordTimeDTO.fromJson(Map<String, dynamic> json) =
      _$RecordTimeDTOImpl.fromJson;

// required String id,
  @override
  String get taskId;
  @override
  String get date;
  @override
  int get recordTime;
  @override
  String? get contents;

  /// Create a copy of RecordTimeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordTimeDTOImplCopyWith<_$RecordTimeDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
