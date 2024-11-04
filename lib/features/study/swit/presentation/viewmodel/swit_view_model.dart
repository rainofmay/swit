import 'package:get/get.dart';
import 'package:swit/features/study/swit/domain/entities/group_invitation.dart';
import 'package:swit/features/study/swit/domain/entities/study_group.dart';
import 'package:swit/features/study/swit/domain/usecases/create_study_group_use_case.dart';
import 'package:swit/features/study/swit/domain/usecases/invite_to_group_use_case.dart';
import 'package:swit/shared/widgets/custom_snackbar.dart';


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
  final RxBool _hasGroup = false.obs;  // 사용자가 그룹을 가지고 있는지 여부
  bool get hasGroup => _hasGroup.value;

  late final Rx<StudyGroup> _myCurrentGroup;


  /* ------------------------------------------------------ */
  /* Function Fields -------------------------------------- */
  /* ------------------------------------------------------ */

  void toggleUserSelection(String userId) {
    if (_selectedUsers.contains(userId)) {
      _selectedUsers.remove(userId);
    } else {
      _selectedUsers.add(userId);
    }
  }

  Future<void> checkExistingGroup() async {
    try {
        _hasGroup.value = await createStudyGroupUseCase.repository.hasExistingGroup();
    } catch (e) {
      print('ViewModel Error checking existing group: $e');
    }
  }

  Future<bool> createGroup() async {
    // if (_groupName.isEmpty) {
    //   Get.snackbar('오류', '스터디 그룹 이름을 입력해주세요.');
    //   return false;
    // }
    // if (_selectedUsers.isEmpty) {
    //   Get.snackbar('오류', '초대할 사용자를 선택해주세요.');
    //   return false;
    // }
    if (_hasGroup.value) {
      CustomSnackbar.show(title: '알림', message: '이미 생성 또는 참여한 그룹스터디가 있습니다.');
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

      return true;
    } catch (e) {

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