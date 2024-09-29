import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swit/core/router/app_pages.dart';
import 'package:swit/features/mate/presentation/widgets/record_card.dart';
import 'package:swit/features/mate/presentation/widgets/study_journal_card.dart';
import 'package:swit/features/record/presentation/view/study_record_screen.dart';
import 'package:swit/features/record/presentation/view/stop_watch_tab.dart';
import 'package:swit/features/record/presentation/view/timer_tab.dart';
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
        length: 2,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            controller.updateTapIndex(tabController.index);
          });

          return SafeArea(
            child: CustomScaffold(
              appBar: const CustomAppBar(appbarTitle: '기 록'),
              floatingActionButton: FloatingActionButton.small(
                backgroundColor: ColorBox.white,
                  onPressed: () {
                    Get.toNamed(Routes.RECORD + Routes.RECORDADD);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/log_black.svg',
                  )),
              body: Column(
                children: [RecordCard(), EditableStudyJournalCard(
                  initialContent: '오늘의 공부 내용을 입력하세요.',
                  initialStudyTime: Duration(hours: 2, minutes: 30),
                  createdAt: DateTime.now(),
                  onSave: (content, studyTime) {
                    // 여기서 저장된 내용을 처리합니다.
                    print('Content: $content');
                    print('Study Time: $studyTime');
                    // 예: 데이터베이스에 저장하거나 상태를 업데이트합니다.
                  },
                )],
              ),
            ),
          );
        }));
  }
}
