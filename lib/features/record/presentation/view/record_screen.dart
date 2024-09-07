import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swit/features/record/presentation/widgets/study_record.dart';
import 'package:swit/features/record/presentation/widgets/stop_watch.dart';
import 'package:swit/features/record/presentation/widgets/timer.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_appbar.dart';
import 'package:swit/shared/widgets/custom_scaffold.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: CustomScaffold(
          appBar: CustomAppBar(appbarTitle: '기 록'),
          body: Column(
            children: [
              TabBar(
                isScrollable: false,
                labelColor: ColorBox.primaryColor,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: ColorBox.grey,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.sticky_note_2_outlined,
                      size: IconSize.md,
                    ),
                    text: '공부 일지',
                  ),
                  Tab(
                    icon: Icon(
                      CupertinoIcons.clock,
                      size: IconSize.md,
                    ),
                    text: '스톱워치',
                  ),
                  Tab(
                    icon: Icon(
                      CupertinoIcons.hourglass,
                      size: IconSize.md,
                    ),
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
      ),
    );
  }
}
