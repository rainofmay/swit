import 'package:swit/features/study/schedule/data/models/schedule_dto.dart';
import 'package:swit/features/study/schedule/domain/entities/schedule.dart';
import 'package:swit/shared/constant/schedule_color.dart';
import 'package:uuid/uuid.dart';

class ScheduleMapper {
  static ScheduleDTO toDTO(Schedule schedule) {
    return ScheduleDTO(
      // uid: schedule.uid,
      id : schedule.id,
      scheduleName: schedule.scheduleName,
      from: schedule.from,
      to: schedule.to,
      description: schedule.description,
      isAllDay: schedule.isAllDay,
      sectionColor: ScheduleColor.colorList.indexOf(schedule.sectionColor),
    );
  }

  static Schedule toEntity(ScheduleDTO dto) {
    return Schedule(
      // uid: dto.uid,
      id : dto.id,
      scheduleName: dto.scheduleName,
      from: dto.from,
      to: dto.to,
      description: dto.description,
      isAllDay: dto.isAllDay,
      sectionColor: ScheduleColor.colorList[dto.sectionColor],
    );
  }
}