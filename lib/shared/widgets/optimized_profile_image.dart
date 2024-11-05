import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swit/core/utils/user/memory_cache.dart';
import 'package:swit/core/utils/user/profile_cache_manager.dart';

class OptimizedProfileImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const OptimizedProfileImage({
    required this.imageUrl,
    this.width = 90,
    this.height = 90,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 로컬 파일 경로인 경우
    if (imageUrl.startsWith('/') || imageUrl.startsWith('file://')) {

      final file = File(imageUrl);
      // 파일 존재 여부 확인
      if (!file.existsSync()) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
        );
      }

      return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.file(
            File(imageUrl),
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
              );
            },
          ),
        ),
      );
    }

    // 네트워크(서버에서 가져오는) 이미지인 경우
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        // CachedNetworkImage가 imageUrl 주소를 가지고 네트워크 이미지를 부름.
        // 이미지가 로드되고 나면 imageProvider가 imageBuilder의 Image 위젯에 전달됨
        child: CachedNetworkImage(
          cacheManager: ProfileCacheManager(),
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          fadeInDuration: Duration.zero,
          placeholderFadeInDuration: Duration.zero,
          memCacheWidth: width.toInt(),
          memCacheHeight: height.toInt(),

          // 메모리 캐시가 있다면, 해당 이미지를 불러옴.
          placeholder: (context, url) {
            final cachedData = MemoryCache.get(url);
            if (cachedData != null) {
              return Image.memory(
                cachedData,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: width,
                    height: height,
                    color: Colors.grey[200],
                  );
                },
              );
            }
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
            );
          },
          imageBuilder: (context, imageProvider) {
            return Image(
              image: imageProvider, // CachedNetworkImage가 제공한 imageProvider를 Image 위젯에 전달
              width: width,
              height: height,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}