// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScheduleDTO _$ScheduleDTOFromJson(Map<String, dynamic> json) {
  return _ScheduleDTO.fromJson(json);
}

/// @nodoc
mixin _$ScheduleDTO {
// required String uid,
  @JsonKey(name: 'schedule_name')
  String get scheduleName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_time_set')
  bool get isTimeSet => throw _privateConstructorUsedError;
  @JsonKey(name: 'section_color')
  int get sectionColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'from')
  @DatetimeConverter()
  DateTime get from => throw _privateConstructorUsedError;
  @JsonKey(name: 'to')
  @DatetimeConverter()
  DateTime get to => throw _privateConstructorUsedError;

  /// Serializes this ScheduleDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleDTOCopyWith<ScheduleDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleDTOCopyWith<$Res> {
  factory $ScheduleDTOCopyWith(
          ScheduleDTO value, $Res Function(ScheduleDTO) then) =
      _$ScheduleDTOCopyWithImpl<$Res, ScheduleDTO>;
  @useResult
  $Res call(
      {@JsonKey(name: 'schedule_name') String scheduleName,
      String? description,
      @JsonKey(name: 'is_time_set') bool isTimeSet,
      @JsonKey(name: 'section_color') int sectionColor,
      @JsonKey(name: 'from') @DatetimeConverter() DateTime from,
      @JsonKey(name: 'to') @DatetimeConverter() DateTime to});
}

/// @nodoc
class _$ScheduleDTOCopyWithImpl<$Res, $Val extends ScheduleDTO>
    implements $ScheduleDTOCopyWith<$Res> {
  _$ScheduleDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleName = null,
    Object? description = freezed,
    Object? isTimeSet = null,
    Object? sectionColor = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      scheduleName: null == scheduleName
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isTimeSet: null == isTimeSet
          ? _value.isTimeSet
          : isTimeSet // ignore: cast_nullable_to_non_nullable
              as bool,
      sectionColor: null == sectionColor
          ? _value.sectionColor
          : sectionColor // ignore: cast_nullable_to_non_nullable
              as int,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleDTOImplCopyWith<$Res>
    implements $ScheduleDTOCopyWith<$Res> {
  factory _$$ScheduleDTOImplCopyWith(
          _$ScheduleDTOImpl value, $Res Function(_$ScheduleDTOImpl) then) =
      __$$ScheduleDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'schedule_name') String scheduleName,
      String? description,
      @JsonKey(name: 'is_time_set') bool isTimeSet,
      @JsonKey(name: 'section_color') int sectionColor,
      @JsonKey(name: 'from') @DatetimeConverter() DateTime from,
      @JsonKey(name: 'to') @DatetimeConverter() DateTime to});
}

/// @nodoc
class __$$ScheduleDTOImplCopyWithImpl<$Res>
    extends _$ScheduleDTOCopyWithImpl<$Res, _$ScheduleDTOImpl>
    implements _$$ScheduleDTOImplCopyWith<$Res> {
  __$$ScheduleDTOImplCopyWithImpl(
      _$ScheduleDTOImpl _value, $Res Function(_$ScheduleDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduleDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleName = null,
    Object? description = freezed,
    Object? isTimeSet = null,
    Object? sectionColor = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$ScheduleDTOImpl(
      scheduleName: null == scheduleName
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isTimeSet: null == isTimeSet
          ? _value.isTimeSet
          : isTimeSet // ignore: cast_nullable_to_non_nullable
              as bool,
      sectionColor: null == sectionColor
          ? _value.sectionColor
          : sectionColor // ignore: cast_nullable_to_non_nullable
              as int,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleDTOImpl implements _ScheduleDTO {
  const _$ScheduleDTOImpl(
      {@JsonKey(name: 'schedule_name') required this.scheduleName,
      this.description,
      @JsonKey(name: 'is_time_set') required this.isTimeSet,
      @JsonKey(name: 'section_color') required this.sectionColor,
      @JsonKey(name: 'from') @DatetimeConverter() required this.from,
      @JsonKey(name: 'to') @DatetimeConverter() required this.to});

  factory _$ScheduleDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleDTOImplFromJson(json);

// required String uid,
  @override
  @JsonKey(name: 'schedule_name')
  final String scheduleName;
  @override
  final String? description;
  @override
  @JsonKey(name: 'is_time_set')
  final bool isTimeSet;
  @override
  @JsonKey(name: 'section_color')
  final int sectionColor;
  @override
  @JsonKey(name: 'from')
  @DatetimeConverter()
  final DateTime from;
  @override
  @JsonKey(name: 'to')
  @DatetimeConverter()
  final DateTime to;

  @override
  String toString() {
    return 'ScheduleDTO(scheduleName: $scheduleName, description: $description, isTimeSet: $isTimeSet, sectionColor: $sectionColor, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleDTOImpl &&
            (identical(other.scheduleName, scheduleName) ||
                other.scheduleName == scheduleName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isTimeSet, isTimeSet) ||
                other.isTimeSet == isTimeSet) &&
            (identical(other.sectionColor, sectionColor) ||
                other.sectionColor == sectionColor) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, scheduleName, description,
      isTimeSet, sectionColor, from, to);

  /// Create a copy of ScheduleDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleDTOImplCopyWith<_$ScheduleDTOImpl> get copyWith =>
      __$$ScheduleDTOImplCopyWithImpl<_$ScheduleDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleDTOImplToJson(
      this,
    );
  }
}

abstract class _ScheduleDTO implements ScheduleDTO {
  const factory _ScheduleDTO(
      {@JsonKey(name: 'schedule_name') required final String scheduleName,
      final String? description,
      @JsonKey(name: 'is_time_set') required final bool isTimeSet,
      @JsonKey(name: 'section_color') required final int sectionColor,
      @JsonKey(name: 'from') @DatetimeConverter() required final DateTime from,
      @JsonKey(name: 'to')
      @DatetimeConverter()
      required final DateTime to}) = _$ScheduleDTOImpl;

  factory _ScheduleDTO.fromJson(Map<String, dynamic> json) =
      _$ScheduleDTOImpl.fromJson;

// required String uid,
  @override
  @JsonKey(name: 'schedule_name')
  String get scheduleName;
  @override
  String? get description;
  @override
  @JsonKey(name: 'is_time_set')
  bool get isTimeSet;
  @override
  @JsonKey(name: 'section_color')
  int get sectionColor;
  @override
  @JsonKey(name: 'from')
  @DatetimeConverter()
  DateTime get from;
  @override
  @JsonKey(name: 'to')
  @DatetimeConverter()
  DateTime get to;

  /// Create a copy of ScheduleDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleDTOImplCopyWith<_$ScheduleDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
