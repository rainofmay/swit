import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProfileCacheManager extends CacheManager {
  static const key = 'PROFILE_CACHE';
  static ProfileCacheManager? _instance;

  factory ProfileCacheManager() {
    _instance ??= ProfileCacheManager._();
    return _instance!;
  }

  ProfileCacheManager._() : super(Config(
    key, // 캐시를 구분하는 고유 식별자
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 200, // 최대로 저장할 수 있는 파일 수
    repo: JsonCacheInfoRepository(databaseName: key), // 캐시된 파일들의 메타데이터 관리
    fileService: HttpFileService(), // 실제 파일 다운로드 처리
    fileSystem: IOFileSystem(key), // 디바이스 저장소 접근 관리
  ));

  Future<void> preloadImages(List<String> urls) async {
    for (final url in urls) {
      try {
        await downloadFile(url);
      } catch (e) {
        print('Failed to preload: $url');
      }
    }
  }
}