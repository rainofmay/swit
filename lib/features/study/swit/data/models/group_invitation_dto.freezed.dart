// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_invitation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupInvitationDTO _$GroupInvitationDTOFromJson(Map<String, dynamic> json) {
  return _GroupInvitationDTO.fromJson(json);
}

/// @nodoc
mixin _$GroupInvitationDTO {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get invitedUserId => throw _privateConstructorUsedError;
  String get invitedById => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get invitedAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupInvitationDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupInvitationDTOCopyWith<GroupInvitationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInvitationDTOCopyWith<$Res> {
  factory $GroupInvitationDTOCopyWith(
          GroupInvitationDTO value, $Res Function(GroupInvitationDTO) then) =
      _$GroupInvitationDTOCopyWithImpl<$Res, GroupInvitationDTO>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String invitedUserId,
      String invitedById,
      String status,
      DateTime invitedAt,
      DateTime? respondedAt});
}

/// @nodoc
class _$GroupInvitationDTOCopyWithImpl<$Res, $Val extends GroupInvitationDTO>
    implements $GroupInvitationDTOCopyWith<$Res> {
  _$GroupInvitationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? invitedUserId = null,
    Object? invitedById = null,
    Object? status = null,
    Object? invitedAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedUserId: null == invitedUserId
          ? _value.invitedUserId
          : invitedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedById: null == invitedById
          ? _value.invitedById
          : invitedById // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupInvitationDTOImplCopyWith<$Res>
    implements $GroupInvitationDTOCopyWith<$Res> {
  factory _$$GroupInvitationDTOImplCopyWith(_$GroupInvitationDTOImpl value,
          $Res Function(_$GroupInvitationDTOImpl) then) =
      __$$GroupInvitationDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String invitedUserId,
      String invitedById,
      String status,
      DateTime invitedAt,
      DateTime? respondedAt});
}

/// @nodoc
class __$$GroupInvitationDTOImplCopyWithImpl<$Res>
    extends _$GroupInvitationDTOCopyWithImpl<$Res, _$GroupInvitationDTOImpl>
    implements _$$GroupInvitationDTOImplCopyWith<$Res> {
  __$$GroupInvitationDTOImplCopyWithImpl(_$GroupInvitationDTOImpl _value,
      $Res Function(_$GroupInvitationDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? invitedUserId = null,
    Object? invitedById = null,
    Object? status = null,
    Object? invitedAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(_$GroupInvitationDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedUserId: null == invitedUserId
          ? _value.invitedUserId
          : invitedUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitedById: null == invitedById
          ? _value.invitedById
          : invitedById // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invitedAt: null == invitedAt
          ? _value.invitedAt
          : invitedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupInvitationDTOImpl implements _GroupInvitationDTO {
  const _$GroupInvitationDTOImpl(
      {required this.id,
      required this.groupId,
      required this.invitedUserId,
      required this.invitedById,
      required this.status,
      required this.invitedAt,
      this.respondedAt});

  factory _$GroupInvitationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInvitationDTOImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String invitedUserId;
  @override
  final String invitedById;
  @override
  final String status;
  @override
  final DateTime invitedAt;
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'GroupInvitationDTO(id: $id, groupId: $groupId, invitedUserId: $invitedUserId, invitedById: $invitedById, status: $status, invitedAt: $invitedAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInvitationDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.invitedUserId, invitedUserId) ||
                other.invitedUserId == invitedUserId) &&
            (identical(other.invitedById, invitedById) ||
                other.invitedById == invitedById) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, invitedUserId,
      invitedById, status, invitedAt, respondedAt);

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInvitationDTOImplCopyWith<_$GroupInvitationDTOImpl> get copyWith =>
      __$$GroupInvitationDTOImplCopyWithImpl<_$GroupInvitationDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupInvitationDTOImplToJson(
      this,
    );
  }
}

abstract class _GroupInvitationDTO implements GroupInvitationDTO {
  const factory _GroupInvitationDTO(
      {required final String id,
      required final String groupId,
      required final String invitedUserId,
      required final String invitedById,
      required final String status,
      required final DateTime invitedAt,
      final DateTime? respondedAt}) = _$GroupInvitationDTOImpl;

  factory _GroupInvitationDTO.fromJson(Map<String, dynamic> json) =
      _$GroupInvitationDTOImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get invitedUserId;
  @override
  String get invitedById;
  @override
  String get status;
  @override
  DateTime get invitedAt;
  @override
  DateTime? get respondedAt;

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInvitationDTOImplCopyWith<_$GroupInvitationDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
