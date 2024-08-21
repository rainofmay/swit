import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/constant/color_box.dart';
import 'package:swit/domain/entities/home_tab_type.dart';
import 'package:swit/presentations/view/bookmark/bookmark_screen.dart';
import 'package:swit/presentations/view/mate/mate_screen.dart';
import 'package:swit/presentations/view/more/more.screen.dart';
import 'package:swit/presentations/view/record/record_screen.dart';
import 'package:swit/presentations/view/study/study_screen.dart';
import 'package:swit/presentations/viewmodel/bottombar_viewmodel.dart';
import 'package:swit/presentations/widgets/common/custom_appbar.dart';
import 'package:swit/presentations/widgets/common/custom_bottom_navigation_bar.dart';
import 'package:swit/presentations/widgets/common/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final BottomBarViewModel vm = Get.find<BottomBarViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        // appBar: CustomAppBar(
        //   backgroundColor: ColorBox.transparent,
        //   contentColor: ColorBox.black,
        // ),
        body: Obx(() => _buildTabScreen(vm.currentTab)),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

Widget _buildTabScreen(HomeTab tab) {
  // switch 패턴 매칭
  switch (tab) {
    case HomeTab.home:
      return StudyScreen();
    case HomeTab.record:
      return const RecordScreen();
    case HomeTab.mate:
      return const MateScreen();
    case HomeTab.more:
      return const MoreScreen();
  }
}
