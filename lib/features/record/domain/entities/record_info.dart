class RecordInfo {
  final String id;
  final String date;
  final String taskId;
  final int recordTime;
  final String title;
  final String? contents;

  RecordInfo({
    required this.id,
    required this.taskId,
    required String? date,
    required this.recordTime,
    required this.title,
    this.contents,
  }) : date = date ?? DateTime.now().toUtc().toString().substring(0, 10);
}