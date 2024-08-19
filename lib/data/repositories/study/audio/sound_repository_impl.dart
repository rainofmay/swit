import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swit/data/data_source/remote/study/audio/sound_remote_data_source.dart';
import 'package:swit/domain/repository/study/audio/sound_repository.dart';
import 'package:swit/domain/entities/study/audio/audio.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundRemoteDataSource remoteDataSource;
  SoundRepositoryImpl(this.remoteDataSource);


  @override
  Future<List<Audio>> getSounds() async{
    try {
      List<DocumentSnapshot> documents = await remoteDataSource.getSounds();
      return documents.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Audio(
          id: data['id'],
          name: data['name'],
          theme: data['theme'],
          audioURL: data['audioURL'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get sounds: $e');
    }
  }
}