import 'package:get/get.dart';


class SwitViewModel extends GetxController {

  late final RxString _groupName = 'Swit'.obs;
  late final RxList<String> _selectedUsers = <String>[].obs;
  List<String> get selectedUsers => _selectedUsers;

  late final RxBool _isCreatingGroup = false.obs;

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
      // TODO: Implement actual group creation logic here
      // This might involve API calls to your backend
      await Future.delayed(Duration(seconds: 2)); // Simulating network request

      // TODO: Send invitations to selected users
      for (var userId in _selectedUsers) {
        // Implement invitation sending logic
        print('Sending invitation to user: $userId');
      }

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