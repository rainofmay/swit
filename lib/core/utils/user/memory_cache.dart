import 'dart:typed_data';

class MemoryCache {
  static final Map<String, Uint8List> _cache = {};

  static void store(String key, Uint8List data) {
    _cache[key] = data;
  }

  static Uint8List? get(String key) {
    return _cache[key];
  }

  static void clear() {
    _cache.clear();
  }
}