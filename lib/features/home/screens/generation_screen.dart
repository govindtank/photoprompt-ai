import 'package:flutter/material.dart';
import '../../../core/config/constants.dart';
/// Main Image Generation Screen - Premium creative tool interface
class GenerationScreen extends StatefulWidget {
  const GenerationScreen({super.key});

  @override
  State<GenerationScreen> createState() => _GenerationScreenState();
}

class _GenerationScreenState extends State<GenerationScreen> 
    with TickerProviderStateMixin {
  final TextEditingController _promptController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  String? _imageUrl;
  bool _isGenerating = false;
  double _generationProgress = 0.0;
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    _focusNode.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> generateImage() async {
    if (_promptController.text.trim().isEmpty) {
      _showSnackBar('✨ Please enter a creative prompt...', isError: true);
      return;
    }

    setState(() {
      _isGenerating = true;
      _generationProgress = 0.0;
      _imageUrl = null;
    });

    try {
      // Animate progress
      for (int i = 0; i <= 100; i += 5) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          setState(() => _generationProgress = i / 100);
        }
      }
      
      // Get sample image URL
      final imageUrl = 'https://picsum.photos/1024/1024?random=${DateTime.now().millisecondsSinceEpoch}';

      setState(() {
        _imageUrl = imageUrl;
        _isGenerating = false;
      });

    } catch (e) {
      setState(() => _isGenerating = false);
      _showSnackBar('❌ Generation failed. Please try again.', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: isError ? Constants.errorColor : Constants.successColor,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Premium Header
              _buildHeader(),
              
              // Main Content
              Expanded(
                child: isWide 
                  ? _buildWideLayout() 
                  : _buildNarrowLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Logo & Brand
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: Constants.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Constants.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PhotoPrompt AI',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Constants.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Create stunning images with AI',
                style: TextStyle(
                  fontSize: 13,
                  color: Constants.textMuted,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Model Badge
          _buildModelBadge(),
        ],
      ),
    );
  }

  Widget _buildModelBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Constants.successColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Constants.successColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Constants.successColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Constants.successColor.withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'FLUX.1 Schnell',
            style: TextStyle(
              color: Constants.successColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Prompt Input
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: _buildPromptSection(),
          ),
        ),
        // Right: Result Display
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: _buildResultSection(),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildPromptSection(),
          const SizedBox(height: 24),
          _buildResultSection(),
        ],
      ),
    );
  }

  Widget _buildPromptSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.edit_note_rounded,
                color: Constants.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Describe Your Vision',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Constants.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Premium Input Card
        Container(
          decoration: BoxDecoration(
            color: Constants.surfaceColor,
            borderRadius: BorderRadius.circular(Constants.borderRadiusLg),
            border: Border.all(
              color: Constants.surfaceLight,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _promptController,
                focusNode: _focusNode,
                maxLines: 6,
                minLines: 4,
                style: const TextStyle(
                  color: Constants.textPrimary,
                  fontSize: 16,
                  height: 1.6,
                ),
                decoration: InputDecoration(
                  hintText: 'A mystical forest at twilight with glowing fireflies...',
                  hintStyle: TextStyle(color: Constants.textMuted),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
              // Prompt Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Constants.surfaceLight.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.borderRadiusLg),
                    bottomRight: Radius.circular(Constants.borderRadiusLg),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, 
                        color: Constants.accentColor, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tip: Include details about style, mood, lighting, and composition',
                        style: TextStyle(
                          color: Constants.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Generate Button
        _buildGenerateButton(),
        
        const SizedBox(height: 32),
        
        // Quick Prompt Suggestions
        _buildQuickPrompts(),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
            boxShadow: _isGenerating ? null : [
              BoxShadow(
                color: Constants.primaryColor.withOpacity(0.4 * _pulseAnimation.value),
                blurRadius: 30 * _pulseAnimation.value,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isGenerating ? null : generateImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                disabledBackgroundColor: Constants.primaryColor.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isGenerating) ...[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Creating Magic... ${(_generationProgress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    const Icon(Icons.auto_awesome, size: 22),
                    const SizedBox(width: 10),
                    const Text(
                      'Generate Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickPrompts() {
    final suggestions = [
      '🎨 Cyberpunk city at night',
      '🌅 Serene beach sunset',
      '🦊 Fantasy fox portrait',
      '🏰 Floating castle in clouds',
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Prompts',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Constants.textMuted,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: suggestions.map((prompt) {
            return InkWell(
              onTap: () {
                _promptController.text = prompt.substring(2);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Constants.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Constants.surfaceLight,
                  ),
                ),
                child: Text(
                  prompt,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Constants.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Constants.secondaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.image_outlined,
                color: Constants.secondaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Generated Image',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Constants.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Result Container
        Container(
          constraints: const BoxConstraints(minHeight: 400),
          decoration: BoxDecoration(
            color: Constants.surfaceColor,
            borderRadius: BorderRadius.circular(Constants.borderRadiusLg),
            border: Border.all(
              color: Constants.surfaceLight,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Constants.borderRadiusLg),
            child: _buildResultContent(),
          ),
        ),
        
        // Action Buttons
        if (_imageUrl != null) ...[
          const SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ],
    );
  }

  Widget _buildResultContent() {
    if (_isGenerating) {
      return _buildLoadingState();
    }
    
    if (_imageUrl != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            _imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorState();
            },
          ),
          // Shimmer overlay for polish
          AnimatedBuilder(
            animation: _shimmerAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1 + _shimmerAnimation.value, 0),
                    end: Alignment(_shimmerAnimation.value, 0),
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
    
    return _buildEmptyState();
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated orb
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 120 * _pulseAnimation.value,
                height: 120 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Constants.primaryColor.withOpacity(0.3),
                      Constants.secondaryColor.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: Constants.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Constants.primaryColor.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            '✨ Creating your masterpiece...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Constants.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This usually takes 10-30 seconds',
            style: TextStyle(
              fontSize: 14,
              color: Constants.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          // Progress bar
          Container(
            width: 200,
            height: 6,
            decoration: BoxDecoration(
              color: Constants.surfaceLight,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _generationProgress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: Constants.primaryGradient,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${(_generationProgress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Constants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.surfaceLight,
              border: Border.all(
                color: Constants.primaryColor.withOpacity(0.2),
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 44,
              color: Constants.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your creation awaits',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Constants.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter a prompt and click Generate\nto create something amazing',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Constants.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.errorColor.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 40,
              color: Constants.errorColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Constants.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please try generating again',
            style: TextStyle(
              fontSize: 14,
              color: Constants.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.download_rounded,
            label: 'Download',
            onTap: () => _showSnackBar('📥 Download started'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.share_rounded,
            label: 'Share',
            onTap: () => _showSnackBar('🔗 Share link copied'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.copy_rounded,
            label: 'Copy Prompt',
            onTap: () {
              _promptController.text = '';
              _showSnackBar('✨ Ready for new prompt');
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Constants.surfaceLight,
            borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Constants.textPrimary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Constants.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
