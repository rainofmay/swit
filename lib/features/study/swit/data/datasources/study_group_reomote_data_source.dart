// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class GoogleLoginRemoteDataSource {
//   GoogleLoginRemoteDataSource._internal();
//
//   static final GoogleLoginRemoteDataSource _instance = GoogleLoginRemoteDataSource
//       ._internal();
//
//   factory GoogleLoginRemoteDataSource () {
//     return _instance;
//   }
//
//   final supabase = Supabase.instance.client;
//
//   Future<void> createStudyGroup(String name, String description) async {
//     final response = await supabase
//         .from('study_groups')
//         .insert({
//       'name': name,
//       'description': description,
//       'created_by': supabase.auth.currentUser!.id,
//     });
//
//     if (response.error == null) {
//       final newGroup = StudyGroup.fromJson(response.data[0]);
//       // 여기서 상태 관리 로직 (예: GetX, Provider 등)을 사용하여 UI 업데이트
//     }
//   }
//
// // 그룹 초대 생성
//   Future<void> inviteToGroup(String groupId, String invitedUserId) async {
//     final response = await supabase
//         .from('group_invitations')
//         .insert({
//       'group_id': groupId,
//       'invited_user_id': invitedUserId,
//       'invited_by': supabase.auth.currentUser!.id,
//     });
//
//     if (response.error == null) {
//       final newInvitation = GroupInvitation.fromJson(response.data[0]);
//       // 초대 생성 후 처리 로직
//     }
//   }
//
// // 그룹 멤버 조회
//   Future<List<GroupMember>> getGroupMembers(String groupId) async {
//     final response = await supabase
//         .from('group_members')
//         .select()
//         .eq('group_id', groupId);
//
//     if (response.error == null) {
//       return (response.data as List)
//           .map((member) => GroupMember.fromJson(member))
//           .toList();
//     }
//     return [];
//   }
//
//
// }
