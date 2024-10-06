class RecordTime {
  // final String id;
  final String date;
  final String taskId;
  final int recordTime;
  final String? contents;

  RecordTime({
    // required this.id,
    required this.taskId,
    required String? date,
    required this.recordTime,
    this.contents,
  }) : date = date ?? DateTime.now().toUtc().toString().substring(0, 10);
}