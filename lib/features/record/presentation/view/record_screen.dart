import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/view/study_record_screen.dart';
import 'package:swit/features/record/presentation/view/stop_watch_screen.dart';
import 'package:swit/features/record/presentation/view/timer_screen.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class RecordScreen extends GetView<RecordViewModel> {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            controller.updateTapIndex(tabController.index);
          });

          return SafeArea(
            child: CustomScaffold(
              appBar: const CustomAppBar(appbarTitle: '기 록'),
              body: Column(
                children: [
                  TabBar(
                    isScrollable: false,
                    labelColor: ColorBox.primaryColor,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: ColorBox.grey,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset('assets/icons/log_black.svg'),
                        text: '공부 일지',
                      ),
                       Tab(
                        icon: SvgPicture.asset('assets/icons/record/stop_watch.svg'),
                        text: '스톱워치',
                      ),
                       Tab(
                        icon: SvgPicture.asset('assets/icons/record/timer.svg'),
                        text: '타이머',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const StudyRecordScreen(),
                        const StopWatchScreen(),
                        TimerScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
