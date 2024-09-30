import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swit/features/study/schedule/presentation/viewmodel/schedule_view_model.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/theme_color.dart';

class ColorSelection extends StatelessWidget {
  ColorSelection({super.key});

  final ScheduleViewModel vm = Get.find<ScheduleViewModel>();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 240,
      height: 200,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(), // 터치 스크롤현상 없애는 것.
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        itemCount: ThemeColor.colorList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1.8,
          //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 20, // 세로 간격
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Obx(() => GestureDetector(
            onTap: () {
              vm.updateScheduleColor(ThemeColor.colorList[index]);
            },
            child: CircleAvatar(
                backgroundColor: ThemeColor.colorList[index],
                child: vm.editingSchedule.sectionColor == ThemeColor.colorList[index]
                    ? Icon(
                  Icons.check_rounded,
                  color: ColorBox.white,
                  size: 19,
                )
                    : null),
          ));
        },
      ),
    );
  }
}
