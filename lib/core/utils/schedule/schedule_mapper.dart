import 'package:swit/features/study/schedule/data/models/schedule_dto.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/shared/constant/schedule_color.dart';

class ScheduleMapper {
  static ScheduleDTO toDTO(Schedule schedule) {
    return ScheduleDTO(
      // uid: schedule.uid,
      scheduleName: schedule.scheduleName,
      from: schedule.from,
      to: schedule.to,
      description: schedule.description,
      isTimeSet: schedule.isTimeSet,
      sectionColor: ScheduleColor.colorList.indexOf(schedule.sectionColor),
    );
  }

  static Schedule toEntity(ScheduleDTO dto) {
    return Schedule(
      // uid: dto.uid,
      scheduleName: dto.scheduleName,
      from: dto.from,
      to: dto.to,
      description: dto.description,
      isTimeSet: dto.isTimeSet,
      sectionColor: ScheduleColor.colorList[dto.sectionColor],
    );
  }
}