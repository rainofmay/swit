// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecordInfoDTO _$RecordInfoDTOFromJson(Map<String, dynamic> json) {
  return _RecordInfoDTO.fromJson(json);
}

/// @nodoc
mixin _$RecordInfoDTO {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get recordTime => throw _privateConstructorUsedError;
  String? get contents => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this RecordInfoDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordInfoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordInfoDTOCopyWith<RecordInfoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordInfoDTOCopyWith<$Res> {
  factory $RecordInfoDTOCopyWith(
          RecordInfoDTO value, $Res Function(RecordInfoDTO) then) =
      _$RecordInfoDTOCopyWithImpl<$Res, RecordInfoDTO>;
  @useResult
  $Res call(
      {String id, String date, int recordTime, String? contents, String title});
}

/// @nodoc
class _$RecordInfoDTOCopyWithImpl<$Res, $Val extends RecordInfoDTO>
    implements $RecordInfoDTOCopyWith<$Res> {
  _$RecordInfoDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordInfoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? recordTime = null,
    Object? contents = freezed,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordInfoDTOImplCopyWith<$Res>
    implements $RecordInfoDTOCopyWith<$Res> {
  factory _$$RecordInfoDTOImplCopyWith(
          _$RecordInfoDTOImpl value, $Res Function(_$RecordInfoDTOImpl) then) =
      __$$RecordInfoDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String date, int recordTime, String? contents, String title});
}

/// @nodoc
class __$$RecordInfoDTOImplCopyWithImpl<$Res>
    extends _$RecordInfoDTOCopyWithImpl<$Res, _$RecordInfoDTOImpl>
    implements _$$RecordInfoDTOImplCopyWith<$Res> {
  __$$RecordInfoDTOImplCopyWithImpl(
      _$RecordInfoDTOImpl _value, $Res Function(_$RecordInfoDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordInfoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? recordTime = null,
    Object? contents = freezed,
    Object? title = null,
  }) {
    return _then(_$RecordInfoDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordInfoDTOImpl implements _RecordInfoDTO {
  const _$RecordInfoDTOImpl(
      {required this.id,
      required this.date,
      required this.recordTime,
      this.contents,
      required this.title});

  factory _$RecordInfoDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordInfoDTOImplFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final int recordTime;
  @override
  final String? contents;
  @override
  final String title;

  @override
  String toString() {
    return 'RecordInfoDTO(id: $id, date: $date, recordTime: $recordTime, contents: $contents, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordInfoDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.recordTime, recordTime) ||
                other.recordTime == recordTime) &&
            (identical(other.contents, contents) ||
                other.contents == contents) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, recordTime, contents, title);

  /// Create a copy of RecordInfoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordInfoDTOImplCopyWith<_$RecordInfoDTOImpl> get copyWith =>
      __$$RecordInfoDTOImplCopyWithImpl<_$RecordInfoDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordInfoDTOImplToJson(
      this,
    );
  }
}

abstract class _RecordInfoDTO implements RecordInfoDTO {
  const factory _RecordInfoDTO(
      {required final String id,
      required final String date,
      required final int recordTime,
      final String? contents,
      required final String title}) = _$RecordInfoDTOImpl;

  factory _RecordInfoDTO.fromJson(Map<String, dynamic> json) =
      _$RecordInfoDTOImpl.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  int get recordTime;
  @override
  String? get contents;
  @override
  String get title;

  /// Create a copy of RecordInfoDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordInfoDTOImplCopyWith<_$RecordInfoDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
