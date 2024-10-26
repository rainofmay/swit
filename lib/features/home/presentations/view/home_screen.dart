import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/app/enums/home_tab_type.dart';
import 'package:swit/core/di/mate_binding.dart';
import 'package:swit/core/di/record_binding.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/home/presentations/viewmodel/home_view_model.dart';
import 'package:swit/features/mate/presentation/view/mate_screen.dart';
import 'package:swit/features/more/presentation/view/more.screen.dart';
import 'package:swit/features/record/presentation/view/record_screen.dart';
import 'package:swit/features/study/study_screen.dart';
import 'package:swit/features/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class HomeScreen extends GetView<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Obx(() {
          // 탭이 변경될 때마다 바인딩 적용
          final currentTab = controller.currentTab;
          return IndexedStack(
            index: currentTab.index,
            children: [
              const StudyScreen(),
              const MateScreen(),

              // 앱 실행 시 바로 메모리에 올리지 않고, 탭 이동 시에만 의존성 주입
              _buildScreen(HomeTab.record, const RecordScreen()),
              _buildScreen(HomeTab.record, MoreScreen()),
            ],
          );
        }),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildScreen(HomeTab tab, Widget screen) {
    // 해당 탭일 때만 화면 반환
    return Obx(() => controller.currentTab == tab ? screen : Container());
  }
}

// class HomeScreen extends GetView<HomeViewModel> {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomScaffold(
//         body: Obx(() => _buildTabScreen(controller.currentTab)),
//         bottomNavigationBar: CustomBottomNavigationBar(),
//       ),
//     );
//   }
// }
//
// Widget _buildTabScreen(HomeTab tab) {
//   // switch 패턴 매칭
//   switch (tab) {
//     case HomeTab.home:
//       return StudyScreen();
//     case HomeTab.mate:
//       return MateScreen();
//     case HomeTab.record:
//       return RecordScreen();
//     case HomeTab.more:
//       return MoreScreen();
//   }
// }