import 'package:get/get.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/usecases/create_study_group_use_case.dart';
import 'package:swit/features/study/swit/domain/usecases/invite_to_group_use_case.dart';


class SwitViewModel extends GetxController {
  final CreateStudyGroupUseCase createStudyGroupUseCase;
  final InviteToGroupUseCase inviteToGroupUseCase;

  SwitViewModel({
    required this.createStudyGroupUseCase,
    required this.inviteToGroupUseCase,
  });

  /* ------------------------------------------------------ */
  /* Variable Fields -------------------------------------- */
  /* ------------------------------------------------------ */

  // 그룹명, 부제목은 초기 런칭 시 'Swit'으로 통일
  final RxString _groupName = 'Swit'.obs;
  final RxString _description = 'Swit'.obs;

  late final RxList<String> _selectedUsers = <String>[].obs;
  List<String> get selectedUsers => _selectedUsers;
  late final RxBool _isCreatingGroup = false.obs;


  /* ------------------------------------------------------ */
  /* Function Fields -------------------------------------- */
  /* ------------------------------------------------------ */
  void setGroupName(String name) {
    _groupName.value = name;
  }

  void toggleUserSelection(String userId) {
    if (_selectedUsers.contains(userId)) {
      _selectedUsers.remove(userId);
    } else {
      _selectedUsers.add(userId);
    }
  }

  Future<bool> createGroup() async {
    if (_groupName.isEmpty) {
      Get.snackbar('오류', '스터디 그룹 이름을 입력해주세요.');
      return false;
    }
    if (_selectedUsers.isEmpty) {
      Get.snackbar('오류', '초대할 사용자를 선택해주세요.');
      return false;
    }

    _isCreatingGroup.value = true;

    try {
      // Create the study group
      StudyGroup createdGroup = await createStudyGroupUseCase.execute(_groupName.value, _description.value);

      // Invite selected users
      List<Future<GroupInvitation>> invitationFutures = _selectedUsers.map(
              (userId) => inviteToGroupUseCase.execute(createdGroup.groupId, userId)
      ).toList();

      // 모든 Future가 완료될 때까지 기다린 후, 모든 결과를 리스트로 반환
      await Future.wait(invitationFutures);

      Get.snackbar('성공', '스터디 그룹이 생성되었고 초대가 발송되었습니다.');
      return true;
    } catch (e) {
      Get.snackbar('오류', '그룹 생성 중 문제가 발생했습니다: $e');
      return false;
    } finally {
      _isCreatingGroup.value = false;
    }
  }

  void resetGroupCreation() {
    _groupName.value = '';
    _selectedUsers.clear();
  }
}