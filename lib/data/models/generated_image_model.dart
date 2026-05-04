/// Simple data structures for storing image generation data
// Note: In production, replace with Hive adapters for persistent storage
class GeneratedImageModel {
  final String id;
  final String prompt;
  final String model;
  final String imageUrl;
  final DateTime createdAt;
  final bool isFavorite;
  final String status;
  
  GeneratedImageModel({
    required this.id,
    required this.prompt,
    required this.model,
    required this.imageUrl,
    DateTime? createdAt,
    this.isFavorite = false,
    this.status = 'completed',
  }) : createdAt = createdAt ?? DateTime.now();
}

/// Model for custom prompts
class CustomPromptModel {
  final String id;
  final String text;
  final String category;
  final List<String> tags;
  final String difficulty;
  
  CustomPromptModel({
    required this.id,
    required this.text,
    required this.category,
    required this.tags,
    required this.difficulty,
  });
}
