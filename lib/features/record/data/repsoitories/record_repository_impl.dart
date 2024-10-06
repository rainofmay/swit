import 'package:swit/core/utils/record/record_mapper.dart';
import 'package:swit/features/record/data/datasources/record_remote_data_source.dart';
import 'package:swit/features/record/domain/entities/record_time.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class RecordRepositoryImpl implements RecordRepository {
  final RecordRemoteDataSource remoteDataSource;

  RecordRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createRecord(RecordTime recordTime) async {
    try {
      final dto = RecordMapper.toDTO(recordTime);
      await remoteDataSource.createRecord(dto);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to create record: $e');
    }
  }
}