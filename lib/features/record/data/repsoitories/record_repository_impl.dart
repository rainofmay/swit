import 'package:swit/core/utils/record/record_mapper.dart';
import 'package:swit/features/record/data/datasources/record_remote_data_source.dart';
import 'package:swit/features/record/data/models/record_info_dto.dart';
import 'package:swit/features/record/domain/entities/record_info.dart';
import 'package:swit/features/record/domain/entities/task.dart';
import 'package:swit/features/record/domain/repositories/record_repository.dart';

class RecordRepositoryImpl implements RecordRepository {
  final RecordRemoteDataSource remoteDataSource;

  RecordRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RecordInfo>> getRecords() async {
    try {
      final recordsData = await remoteDataSource.getRecords();
      return recordsData.map((record) => RecordMapper.toEntity(RecordMapper.fromJson(record))).toList();
    } catch (e) {
      throw Exception('RepositoryImpl Failed to get records: $e');
    }
  }

  @override
  Future<void> createRecord(RecordInfo recordInfo) async {
    try {
      final dto = RecordMapper.toDTO(recordInfo);
      await remoteDataSource.createRecord(dto);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to create record: $e');
    }
  }

  @override
  Future<void> updateRecord(String id, String newContents) async {
    try {
      await remoteDataSource.updateRecord(id, newContents);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to create record: $e');
    }
  }

  @override
  Future<void> deleteRecord(String id) async {
    try {
      await remoteDataSource.deleteRecord(id);
    } catch (e) {
      throw Exception('RepositoryImpl Failed to delete record: $e');
    }
  }
}