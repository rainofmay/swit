import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swit/core/data/base_remote_datasource.dart';
import 'package:swit/core/utils/swit/group_invitation_mapper.dart';
import 'package:swit/core/utils/swit/study_group_mapper.dart';
import 'package:swit/features/study/swit/data/models/study_group_dto.dart';
import 'package:swit/features/study/swit/data/models/group_invitation_dto.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';

class StudyGroupRemoteDataSource extends BaseRemoteDataSource {

  Future<StudyGroup> createStudyGroup() async {
    try {
      final response = await supabase
          .from('study_group')
          .insert({
        'name': 'swit',
        'description': 'swit',
        'created_by_id': supabase.auth.currentUser!.id,
        'is_active': true,
      }).select().single();

      final dto = StudyGroupDTO.fromJson(response);
      return StudyGroupMapper.fromDto(dto);
    } catch (e) {
      print('Error creating study group: $e');
      throw Exception('Failed to create study group: $e');
    }
  }

  Future<GroupInvitation?> inviteToGroup(String groupId, String invitedUserId) async {
    try {
      final response = await supabase
          .from('group_invitations')
          .insert({
        'group_id': groupId,
        'invited_user_id': invitedUserId,
        'invited_by_id': supabase.auth.currentUser!.id,
        'status': InvitationStatus.pending.toString(),
        'invited_at': DateTime.now().toIso8601String(),
      }).select().single();

      final dto = GroupInvitationDTO.fromJson(response);
      return GroupInvitationMapper.fromDto(dto);
    } catch (e) {
      print('Error inviting to group: $e');
      return null;
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
      print('Error getting group invitations: $e');
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
      print('Error updating invitation status: $e');
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
      return StudyGroupMapper.fromDto(dto);
    } catch (e) {
      print('Error getting study group: $e');
      return null;
    }
  }
}