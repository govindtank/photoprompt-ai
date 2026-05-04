import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Prompts Gallery Screen - Beautiful grid view of all prompts
class PromptsGalleryScreen extends StatelessWidget {
  const PromptsGalleryScreen({super.key});

  // All available prompt categories with descriptions
  static final List<PromptCategory> _categories = [
    PromptCategory(
      id: 'portraits',
      name: 'Portraits',
      icon: Icons.person_outlined,
      color: Colors.pinkAccent,
      description: 'Stunning portrait prompts with cinematic lighting and beauty shots',
      sample: 'a stunning portrait of a young woman with glowing skin, cinematic lighting, shot on 35mm lens',
    ),
    PromptCategory(
      id: 'landscapes',
      name: 'Landscapes',
      icon: Icons.nature_outlined,
      color: Colors.greenAccent,
      description: 'Breathtaking nature and landscape photography prompts',
      sample: 'breathtaking mountain landscape at sunset with golden hour lighting, misty valleys',
    ),
    PromptCategory(
      id: 'abstract',
      name: 'Abstract',
      icon: Icons.palette_outlined,
      color: Colors.blueAccent,
      description: 'Mesmerizing abstract art with flowing colors and geometric patterns',
      sample: 'mesmerizing abstract art with flowing colors and geometric patterns, vibrant neon palette',
    ),
    PromptCategory(
      id: 'characters',
      name: 'Characters',
      icon: Icons.emoji_emotions_outlined,
      color: Colors.orangeAccent,
      description: 'Fantasy character designs with epic cinematic composition',
      sample: 'fantasy character design, intricate armor details, glowing magical runes',
    ),
    PromptCategory(
      id: 'surreal',
      name: 'Surreal',
      icon: Icons.straight_out_of_computer_outlined,
      color: Colors.purpleAccent,
      description: 'Dreamlike surreal scenes with ethereal lighting and hyper-detailed art',
      sample: 'dreamlike surreal scene with floating islands and waterfalls, ethereal lighting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search prompts',
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar (if showing search results)
          if (_isSearching) ...[
            Padding(
              padding: const EdgeInsets.all(Constants.spacingLarge),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search prompts...',
                  prefixIcon: Icon(Icons.search, color: Constants.primaryColor),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                  ),
                ),
                onSubmitted: (query) => Navigator.pop(context),
              ),
            ),
          ],

          // Category Grid
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(Constants.spacingLarge),
              crossAxisCount: 2,
              crossAxisSpacing: Constants.spacingMedium,
              mainAxisSpacing: Constants.spacingMedium,
              children: _categories.map((category) => _buildCategoryCard(context, category)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, PromptCategory category) {
    return Card(
      elevation: Constants.cardElevation,
      child: InkWell(
        onTap: () => _showPromptEditor(context, category),
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Color-coded top bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [category.color.withOpacity(0.8), category.color],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(Constants.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(category.icon, color: category.color, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    category.description,
                    style: TextStyle(fontSize: 12, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Sample preview
            Container(
              margin: const EdgeInsets.all(Constants.spacingSmall),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(Constants.borderRadius),
              ),
              padding: Constants.spacingMedium,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      category.sample,
                      style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Action button
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(Constants.spacingMedium),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showPromptEditor(context, category),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Edit',
                            style: TextStyle(fontSize: 12, color: category.color),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Prompts'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Find a prompt...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) {
            // Search logic here
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ],
      ),
    );
  }

  void _showPromptEditor(BuildContext context, PromptCategory category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${category.name} Prompts'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                category.sample,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pushNamed(context, '/generation');
                  // Auto-fill generation screen with this prompt
                },
                child: const Text('Use in Generator'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _isSearching => false; // Placeholder - would be set when search is active
}

/// Prompt Category Model
class PromptCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final String sample;

  const PromptCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.sample,
  });
}
