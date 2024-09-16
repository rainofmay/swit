import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swit/core/enums/bg_theme.dart';



class BgSettingViewModel extends GetxController {
  late final Rx<BgTheme> _editingTheme = BgTheme.day.obs; // 수정 중인 값
  late final Rx<BgTheme> _storedTheme; // 최종 저장된 값
  BgTheme get editingTheme => _editingTheme.value;


  final RxMap<BgTheme, String> _bgThemeMap = {
    BgTheme.day: 'assets/images/day_photo.jpg',
    BgTheme.night: 'assets/images/night_photo.jpg',
    BgTheme.custom: '',
  }.obs;
  Map<BgTheme, String> get bgThemeMap => _bgThemeMap;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* UPDATE */
  void updateEditingTheme(BgTheme theme) {
    _editingTheme.value = theme;
  }

  void updateCustomImagePath(String path) {
    // 서버에 저장하는 로직 필요
    _bgThemeMap[BgTheme.custom] = path;
    updateEditingTheme(BgTheme.custom);
  }
}


