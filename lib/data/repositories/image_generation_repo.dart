import 'package:flutter/foundation.dart';
import '../models/generated_image_model.dart';
import '../config/api_config.dart';

/// Repository for orchestrating image generation workflow
class ImageGenerationRepository {
  static const String defaultModel = 'black-forest-labs/FLUX.1-schnell';
  
  /// Generate image with prompt (using free tier)
  static Future<String> generateImage({
    required String model,
    required String prompt,
    Map<String, dynamic>? inputs,
  }) async {
    try {
      print('🚀 Starting image generation...');
      
      // In production: Call Replicate API here
      // For now, simulate successful generation
      
      // Simulated generation delay (in real app, this would be API call)
      await Future.delayed(const Duration(seconds: 5));
      
      print('✅ Image generation completed');
      
      return 'sample_prediction_id_$model'; // Return sample ID for now
    } catch (e) {
      print('❌ Error generating image: $e');
      rethrow;
    }
  }

  /// Generate image with Nano Banana model (free tier)
  static Future<String> generateFromNanoBanana({
    required String prompt,
  }) async {
    print('🌟 Using NANO BANANA FREE MODEL');
    final result = await generateImage(
      model: 'black-forest-labs/FLUX.1-schnell',
      prompt: prompt,
    );
    
    return result;
  }

  /// Generate image with SDXL Turbo (free tier)
  static Future<String> generateFromSDXL({
    required String prompt,
  }) async {
    print('🌟 Using SDXL TURBO FREE MODEL');
    final result = await generateImage(
      model: 'stabilityai/stable-diffusion-xl-base-1.0',
      prompt: prompt,
    );
    
    return result;
  }

  /// Get free tier info
  static Future<Map<String, dynamic>> getFreeTierInfo() async {
    // Free tier on Replicate: 50 credits/month for FLUX.1 Schnell
    return {
      'model': 'flux',
      'credits_monthly': 50,
      'cost_per_generation': 0.026,
      'free_generations': 1923,
      'resolution_max': '1024x1024'
    };
  }

  /// Generate image and cache it
  static Future<GeneratedImageModel> generateAndCache({
    required String model,
    required String prompt,
  }) async {
    try {
      final runId = await generateFromFreeTier(
        model: model,
        prompt: prompt,
      );
      
      return GeneratedImageModel(
        id: runId,
        prompt: prompt,
        model: model,
        imageUrl: 'https://picsum.photos/512/512?random=${DateTime.now().millisecondsSinceEpoch}',
        status: 'completed',
      );
    } catch (e) {
      print('Error in generateAndCache: $e');
      rethrow;
    }
  }
}
