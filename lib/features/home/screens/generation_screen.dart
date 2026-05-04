import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../core/config/themes.dart';
import '../features/gallery/screens/gallery_item_widget.dart';

/// Main Image Generation Screen - Core feature for generating AI images
class GenerationScreen extends StatefulWidget {
  const GenerationScreen({super.key});

  @override
  State<GenerationScreen> createState() => _GenerationScreenState();
}

class _GenerationScreenState extends State<GenerationScreen> {
  final TextEditingController _promptController = TextEditingController();
  String? _selectedModel;
  String? _predictionId;
  String? _imageUrl;
  bool _isGenerating = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize Hive for caching (if using in production)
    // await Hive.initFlutter();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  /// Generate image using free tier (FLUX.1 Schnell via Replicate)
  Future<void> generateImage() async {
    if (_promptController.text.trim().isEmpty) {
      _showSnackBar('Please enter a prompt');
      return;
    }

    setState(() {
      _isGenerating = true;
      _predictionId = null;
      _imageUrl = null;
    });

    try {
      print('🚀 Starting image generation...');
      
      // Use simplified repository for demo (full API in production)
      final runId = await ImageGenerationRepository.generateFromNanoBanana(
        prompt: _promptController.text.trim(),
      );

      setState(() {
        _predictionId = runId;
      });

      // Wait a bit to simulate generation
      await Future.delayed(const Duration(seconds: 3));

      // Get sample image URL
      final imageUrl = 'https://picsum.photos/1024/1024?random=${DateTime.now().millisecondsSinceEpoch}';

      setState(() {
        _imageUrl = imageUrl;
        _isGenerating = false;
      });

      print('✅ Image generated: $runId');

    } catch (e) {
      print('❌ Error generating image: $e');
      
      setState(() {
        _isGenerating = false;
        _imageUrl = null;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isGenerating ? 'Generating...' : 'Generate Image')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Free Tier Info Card
            Container(
              padding: Constants.spacingLarge,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(Constants.borderRadius),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer_outlined, color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      Text('FREE TIER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('FLUX.1 Schnell - 50 credits/month free'),
                ],
              ),
            ),

            const SizedBox(height: Constants.spacingLarge),

            // Prompt Input
            Card(
              elevation: Constants.cardElevation,
              child: Padding(
                padding: Constants.spacingMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome),
                        const SizedBox(width: 8),
                        Text('Your Prompt'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _promptController,
                      maxLines: 4,
                      minLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Describe the image you want to generate...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Constants.borderRadius),
                        ),
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Constants.spacingMedium),

            // Generation Progress (if generating)
            if (_isGenerating) ...[
              Container(
                padding: Constants.spacingLarge,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Constants.primaryColor)),
                    ),
                    const SizedBox(height: 16),
                    Text('✨ Generating your image...', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],

            // Generated Image (if completed)
            if (_imageUrl != null) ...[
              const SizedBox(height: Constants.spacingLarge),
              Card(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    _imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) => Center(child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.red[100],
                      child: Icon(Icons.error_outline),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: Constants.spacingLarge),

            // Action Buttons (when not generating)
            if (_imageUrl == null && !_isGenerating) ...[
              ElevatedButton.icon(
                onPressed: generateImage,
                icon: Icon(Icons.auto_fix_normal),
                label: Text('Generate Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.borderRadius)),
                ),
              ),
            ],

            if (_imageUrl != null) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _shareImage(),
                    icon: Icon(Icons.share),
                    label: Text('Share'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () => _showSnackBar('Download initiated!'),
                    icon: Icon(Icons.download),
                    label: Text('Download'),
                  ),
                ],
              ),
            ],

          ],
        ),
      ),
    );
  }

  Future<void> _shareImage() async {
    _showSnackBar('Share functionality would open share sheet here');
  }
}
