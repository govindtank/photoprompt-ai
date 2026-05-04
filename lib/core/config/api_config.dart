import 'constants.dart';

/// Configuration for Replicate API integration
class ApiConfig {
  // API base URL
  static const String baseURL = Constants.replicateApiBase;
  
  // Headers for authentication and requests
  static final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // Image generation endpoint
  static const String generateImagesEndpoint = '/predictions';

  // Models available on Replicate (free tier support)
  static const List<String> freeModels = [
    'black-forest-labs/FLUX.1-schnell',
    'stability-ai/stable-video-diffusion'
  ];

  /// Build API URL for image generation
  static String buildImageUrl(String modelId, String runVersion) {
    return '$baseURL/$modelId/$runVersion/predictions';
  }
}
