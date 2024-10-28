// widgets/optimized_profile_image.dart
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

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
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
          placeholder: (context, url) {
            // 메모리 캐시 확인
            final cachedData = MemoryCache.get(url);
            if (cachedData != null) {
              return Image.memory(
                cachedData,
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
            }
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
            );
          },
          imageBuilder: (context, imageProvider) {
            // 이미지 로드 성공시 메모리 캐시 저장
            WidgetsBinding.instance.addPostFrameCallback((_) {
              imageProvider
                  .resolve(createLocalImageConfiguration(context))
                  .addListener(ImageStreamListener((info, _) async {
                final byteData = await info.image.toByteData();
                if (byteData != null) {
                  MemoryCache.store(imageUrl, byteData.buffer.asUint8List());
                }
              }));
            });
            return Image(
              image: imageProvider,
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