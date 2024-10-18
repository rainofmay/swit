import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_member_dto.freezed.dart';
part 'group_member_dto.g.dart';

@freezed
class GroupMemberDTO with _$GroupMemberDTO {

  const factory GroupMemberDTO({
    required String groupId,
    required String userId,
    required String role,
    required DateTime joinedAt,
  }) = _GroupMemberDTO;

  factory GroupMemberDTO.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberDTOFromJson(json);

}