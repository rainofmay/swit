// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupMemberDTO _$GroupMemberDTOFromJson(Map<String, dynamic> json) {
  return _GroupMemberDTO.fromJson(json);
}

/// @nodoc
mixin _$GroupMemberDTO {
  String get groupId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupMemberDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupMemberDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupMemberDTOCopyWith<GroupMemberDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberDTOCopyWith<$Res> {
  factory $GroupMemberDTOCopyWith(
          GroupMemberDTO value, $Res Function(GroupMemberDTO) then) =
      _$GroupMemberDTOCopyWithImpl<$Res, GroupMemberDTO>;
  @useResult
  $Res call({String groupId, String userId, String role, DateTime joinedAt});
}

/// @nodoc
class _$GroupMemberDTOCopyWithImpl<$Res, $Val extends GroupMemberDTO>
    implements $GroupMemberDTOCopyWith<$Res> {
  _$GroupMemberDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMemberDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupMemberDTOImplCopyWith<$Res>
    implements $GroupMemberDTOCopyWith<$Res> {
  factory _$$GroupMemberDTOImplCopyWith(_$GroupMemberDTOImpl value,
          $Res Function(_$GroupMemberDTOImpl) then) =
      __$$GroupMemberDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String groupId, String userId, String role, DateTime joinedAt});
}

/// @nodoc
class __$$GroupMemberDTOImplCopyWithImpl<$Res>
    extends _$GroupMemberDTOCopyWithImpl<$Res, _$GroupMemberDTOImpl>
    implements _$$GroupMemberDTOImplCopyWith<$Res> {
  __$$GroupMemberDTOImplCopyWithImpl(
      _$GroupMemberDTOImpl _value, $Res Function(_$GroupMemberDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMemberDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(_$GroupMemberDTOImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupMemberDTOImpl implements _GroupMemberDTO {
  const _$GroupMemberDTOImpl(
      {required this.groupId,
      required this.userId,
      required this.role,
      required this.joinedAt});

  factory _$GroupMemberDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupMemberDTOImplFromJson(json);

  @override
  final String groupId;
  @override
  final String userId;
  @override
  final String role;
  @override
  final DateTime joinedAt;

  @override
  String toString() {
    return 'GroupMemberDTO(groupId: $groupId, userId: $userId, role: $role, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMemberDTOImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, groupId, userId, role, joinedAt);

  /// Create a copy of GroupMemberDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMemberDTOImplCopyWith<_$GroupMemberDTOImpl> get copyWith =>
      __$$GroupMemberDTOImplCopyWithImpl<_$GroupMemberDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupMemberDTOImplToJson(
      this,
    );
  }
}

abstract class _GroupMemberDTO implements GroupMemberDTO {
  const factory _GroupMemberDTO(
      {required final String groupId,
      required final String userId,
      required final String role,
      required final DateTime joinedAt}) = _$GroupMemberDTOImpl;

  factory _GroupMemberDTO.fromJson(Map<String, dynamic> json) =
      _$GroupMemberDTOImpl.fromJson;

  @override
  String get groupId;
  @override
  String get userId;
  @override
  String get role;
  @override
  DateTime get joinedAt;

  /// Create a copy of GroupMemberDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMemberDTOImplCopyWith<_$GroupMemberDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
