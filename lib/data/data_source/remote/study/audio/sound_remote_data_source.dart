import 'package:cloud_firestore/cloud_firestore.dart';

class SoundRemoteDataSource {
  SoundRemoteDataSource._internal();
  // _instance : SoundRemoteDataSource의 유일한 인스턴스를 저장
  static final SoundRemoteDataSource _instance = SoundRemoteDataSource._internal();
  factory SoundRemoteDataSource() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getSounds() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sound')
          .orderBy('id')
          .get();

      return querySnapshot.docs;
    }
    catch (e) {
      throw Exception('Error fetching getThemeMusic: $e');
    }
  }
}