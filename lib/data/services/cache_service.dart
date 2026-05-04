import 'package:flutter/foundation.dart';

/// Service for managing local caching of generated images
/// Uses simple in-memory storage (replace with Hive/SharedPreferences for production)
class CacheService {
  static final Map<String, GeneratedImageModel> _imagesCache = {};

  /// Add image to cache
  static void cacheImage(String id, GeneratedImageModel image) {
    _imagesCache[id] = image;
    debugPrint('Image cached: $id');
  }

  /// Get cached image by ID
  static GeneratedImageModel? getCachedImage(String id) {
    return _imagesCache[id];
  }

  /// Toggle favorite status
  static void toggleFavorite(String id, bool isFavorite) {
    final image = _imagesCache[id];
    if (image != null) {
      image.isFavorite = isFavorite;
    }
  }

  /// Check if image is favorite
  static bool isFavorite(String id) {
    final image = _imagesCache[id];
    return image?.isFavorite ?? false;
  }

  /// Get all cached images sorted by date
  static List<GeneratedImageModel> getAllCachedImages() {
    return _imagesCache.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get favorite images only
  static List<GeneratedImageModel> getFavoriteImages() {
    return _imagesCache.values.where((img) => img.isFavorite).toList();
  }

  /// Clear cache for specific image
  static void clearImageCache(String id) {
    _imagesCache.remove(id);
  }

  /// Clear all cache
  static void clearAllCache() {
    _imagesCache.clear();
  }
}
