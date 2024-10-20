import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';
import 'package:swit/core/utils/datetime_converter.dart';
import 'package:swit/core/utils/swit/group_invitation_mapper.dart';
import 'package:swit/core/utils/swit/study_group_mapper.dart';
import 'package:swit/features/study/swit/data/models/study_group_dto.dart';
import 'package:swit/features/study/swit/data/models/group_invitation_dto.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';

class StudyGroupRemoteDataSource extends BaseRemoteDataSource {
  final DatetimeConverter _converter = const DatetimeConverter();

  /* -- 그룹 생성을 리런 함수로 한 이유 -- */
  // 1. 그룹 생성이 실패한 경우, 초대 알림 발송 단계로 넘어가지 않고 즉시 오류를 처리할 수 있음.
  // 2. 그룹을 생성한 후 반환된 그룹 정보(특히 그룹 ID)를 바로 초대 알림 발송에 사용할 수 있음.
  Future<Map<String, dynamic>> createStudyGroup(String name, String description) async {
    try {
      final response = await supabase
          .from('study_group')
          .insert({
        'name': name,
        'description': description,
        'created_by': supabase.auth.currentUser!.id,
        'is_active': true,
      }).select().single();

      return response;
    } catch (e) {
      print('Remote DataSource Error creating study group: $e');
      throw Exception('Failed to create study group: $e');
    }
  }

  Future<Map<String, dynamic>> inviteToGroup(String groupId, String invitedUserId) async {
    try {
      final response = await supabase
          .from('group_invitations')
          .insert({
        'group_id': groupId,
        'invited_user_id': invitedUserId,
        'invited_by': supabase.auth.currentUser!.id,
        'status': InvitationStatus.pending.toString().split('.').last,
        // 'invited_at': _converter.toJson(DateTime.now()),
      }).select().single();

      return response;
    } catch (e) {
      print('Error inviting to group: $e');
      throw Exception('Failed to invite to group: $e');
    }
  }

  Future<List<GroupInvitation>> getGroupInvitations(String groupId) async {
    try {
      final response = await supabase
          .from('group_invitations')
          .select()
          .eq('group_id', groupId);

      return (response as List)
          .map((data) => GroupInvitationMapper.fromDto(GroupInvitationDTO.fromJson(data)))
          .toList();
    } catch (e) {
      print('Remote DataSource Error getting group invitations: $e');
      return [];
    }
  }

  Future<bool> updateInvitationStatus(String invitationId, InvitationStatus status) async {
    try {
      await supabase
          .from('group_invitations')
          .update({
        'status': status.toString(),
        'responded_at': DateTime.now().toIso8601String(),
      })
          .eq('id', invitationId);
      return true;
    } catch (e) {
      print('Remote DataSource Error updating invitation status: $e');
      return false;
    }
  }

  Future<StudyGroup?> getStudyGroup(String groupId) async {
    try {
      final response = await supabase
          .from('study_group')
          .select()
          .eq('group_id', groupId)
          .single();

      final dto = StudyGroupDTO.fromJson(response);
      return StudyGroupMapper.toEntity(dto);
    } catch (e) {
      print('Remote DataSource Error getting study group: $e');
      return null;
    }
  }
}