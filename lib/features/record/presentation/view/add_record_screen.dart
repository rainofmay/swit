import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/features/record/presentation/view/stop_watch_tab.dart';
import 'package:swit/features/record/presentation/view/timer_tab.dart';
import 'package:swit/features/record/presentation/viewmodel/record_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_back_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class AddRecordScreen extends GetView<RecordViewModel> {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        appBar: const CustomBackAppBar(
          appbarTitle: '측 정',
          isLeading: true,
          isCenterTitle: true,
        ),
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
                  icon: SvgPicture.asset(
                    'assets/icons/record/stop_watch.svg',
                    color: ColorBox.primaryColor,
                  ),
                  text: '스톱워치',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    'assets/icons/record/timer.svg',
                    color: ColorBox.primaryColor,
                  ),
                  text: '타이머',
                ),
              ],
              onTap: (index) {
                controller.updateTapIndex(index);
              },
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const StopWatchTab(),
                  TimerTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}