import 'package:swit/features/record/data/models/task_dto.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/shared/constant/theme_color.dart';

class TaskMapper {
  static TaskDTO toDTO(Task task) {
    return TaskDTO(
        title: task.title, color: ThemeColor.colorList.indexOf(task.color), id: task.id);
  }

  static Task toEntity(TaskDTO dto) {
    return Task(title: dto.title, color: ThemeColor.colorList[dto.color], id: dto.id);
  }
}
