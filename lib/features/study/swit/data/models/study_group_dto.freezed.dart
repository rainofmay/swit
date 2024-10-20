// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudyGroupDTO _$StudyGroupDTOFromJson(Map<String, dynamic> json) {
  return _StudyGroupDTO.fromJson(json);
}

/// @nodoc
mixin _$StudyGroupDTO {
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this StudyGroupDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyGroupDTOCopyWith<StudyGroupDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyGroupDTOCopyWith<$Res> {
  factory $StudyGroupDTOCopyWith(
          StudyGroupDTO value, $Res Function(StudyGroupDTO) then) =
      _$StudyGroupDTOCopyWithImpl<$Res, StudyGroupDTO>;
  @useResult
  $Res call(
      {@JsonKey(name: 'group_id') String groupId,
      String name,
      String? description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$StudyGroupDTOCopyWithImpl<$Res, $Val extends StudyGroupDTO>
    implements $StudyGroupDTOCopyWith<$Res> {
  _$StudyGroupDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyGroupDTOImplCopyWith<$Res>
    implements $StudyGroupDTOCopyWith<$Res> {
  factory _$$StudyGroupDTOImplCopyWith(
          _$StudyGroupDTOImpl value, $Res Function(_$StudyGroupDTOImpl) then) =
      __$$StudyGroupDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'group_id') String groupId,
      String name,
      String? description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$StudyGroupDTOImplCopyWithImpl<$Res>
    extends _$StudyGroupDTOCopyWithImpl<$Res, _$StudyGroupDTOImpl>
    implements _$$StudyGroupDTOImplCopyWith<$Res> {
  __$$StudyGroupDTOImplCopyWithImpl(
      _$StudyGroupDTOImpl _value, $Res Function(_$StudyGroupDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudyGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? isActive = null,
  }) {
    return _then(_$StudyGroupDTOImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyGroupDTOImpl implements _StudyGroupDTO {
  const _$StudyGroupDTOImpl(
      {@JsonKey(name: 'group_id') required this.groupId,
      required this.name,
      this.description,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'is_active') required this.isActive});

  factory _$StudyGroupDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyGroupDTOImplFromJson(json);

  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'StudyGroupDTO(groupId: $groupId, name: $name, description: $description, createdAt: $createdAt, createdBy: $createdBy, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyGroupDTOImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, groupId, name, description, createdAt, createdBy, isActive);

  /// Create a copy of StudyGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyGroupDTOImplCopyWith<_$StudyGroupDTOImpl> get copyWith =>
      __$$StudyGroupDTOImplCopyWithImpl<_$StudyGroupDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyGroupDTOImplToJson(
      this,
    );
  }
}

abstract class _StudyGroupDTO implements StudyGroupDTO {
  const factory _StudyGroupDTO(
          {@JsonKey(name: 'group_id') required final String groupId,
          required final String name,
          final String? description,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'created_by') required final String createdBy,
          @JsonKey(name: 'is_active') required final bool isActive}) =
      _$StudyGroupDTOImpl;

  factory _StudyGroupDTO.fromJson(Map<String, dynamic> json) =
      _$StudyGroupDTOImpl.fromJson;

  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of StudyGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyGroupDTOImplCopyWith<_$StudyGroupDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
