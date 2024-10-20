import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_member_dto.freezed.dart';
part 'group_member_dto.g.dart';

@freezed
class GroupMemberDTO with _$GroupMemberDTO {

  const factory GroupMemberDTO({
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'user_id') required String userId,
    required String role,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _GroupMemberDTO;

  factory GroupMemberDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberDTOFromJson(json);

}