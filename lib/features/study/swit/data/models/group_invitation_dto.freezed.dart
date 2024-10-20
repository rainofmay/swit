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
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_user_id')
  String get invitedUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_by')
  String get invitedBy => throw _privateConstructorUsedError;
  InvitationStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'invited_at')
  DateTime get invitedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'responded_at')
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
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'invited_user_id') String invitedUserId,
      @JsonKey(name: 'invited_by') String invitedBy,
      InvitationStatus status,
      @JsonKey(name: 'invited_at') DateTime invitedAt,
      @JsonKey(name: 'responded_at') DateTime? respondedAt});
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
    Object? invitedBy = null,
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
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
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
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'invited_user_id') String invitedUserId,
      @JsonKey(name: 'invited_by') String invitedBy,
      InvitationStatus status,
      @JsonKey(name: 'invited_at') DateTime invitedAt,
      @JsonKey(name: 'responded_at') DateTime? respondedAt});
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
    Object? invitedBy = null,
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
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
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
      @JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'invited_user_id') required this.invitedUserId,
      @JsonKey(name: 'invited_by') required this.invitedBy,
      required this.status,
      @JsonKey(name: 'invited_at') required this.invitedAt,
      @JsonKey(name: 'responded_at') this.respondedAt});

  factory _$GroupInvitationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInvitationDTOImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'invited_user_id')
  final String invitedUserId;
  @override
  @JsonKey(name: 'invited_by')
  final String invitedBy;
  @override
  final InvitationStatus status;
  @override
  @JsonKey(name: 'invited_at')
  final DateTime invitedAt;
  @override
  @JsonKey(name: 'responded_at')
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'GroupInvitationDTO(id: $id, groupId: $groupId, invitedUserId: $invitedUserId, invitedBy: $invitedBy, status: $status, invitedAt: $invitedAt, respondedAt: $respondedAt)';
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
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invitedAt, invitedAt) ||
                other.invitedAt == invitedAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, invitedUserId,
      invitedBy, status, invitedAt, respondedAt);

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
          @JsonKey(name: 'group_id') required final String groupId,
          @JsonKey(name: 'invited_user_id') required final String invitedUserId,
          @JsonKey(name: 'invited_by') required final String invitedBy,
          required final InvitationStatus status,
          @JsonKey(name: 'invited_at') required final DateTime invitedAt,
          @JsonKey(name: 'responded_at') final DateTime? respondedAt}) =
      _$GroupInvitationDTOImpl;

  factory _GroupInvitationDTO.fromJson(Map<String, dynamic> json) =
      _$GroupInvitationDTOImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'invited_user_id')
  String get invitedUserId;
  @override
  @JsonKey(name: 'invited_by')
  String get invitedBy;
  @override
  InvitationStatus get status;
  @override
  @JsonKey(name: 'invited_at')
  DateTime get invitedAt;
  @override
  @JsonKey(name: 'responded_at')
  DateTime? get respondedAt;

  /// Create a copy of GroupInvitationDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInvitationDTOImplCopyWith<_$GroupInvitationDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
