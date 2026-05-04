import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Prompts List Screen - Browse and select prompts
class PromptsListScreen extends StatefulWidget {
  const PromptsListScreen({super.key});

  @override
  State<PromptsListScreen> createState() => _PromptsListScreenState();
}

class _PromptsListScreenState extends State<PromptsListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Categories of prompts available
  static const List<String> categories = [
    'All',
    'Portraits',
    'Landscapes',
    'Abstract',
    'Characters',
    'Surreal'
  ];

  // Sample prompt data (replace with actual JSON files from assets/prompts/)
  static const List<String> samplePrompts = [
    'a stunning portrait of a young woman with glowing skin, cinematic lighting, shot on 35mm lens',
    'breathtaking mountain landscape at sunset with golden hour lighting, misty valleys',
    'mesmerizing abstract art with flowing colors and geometric patterns, vibrant neon palette',
    'fantasy character design, intricate armor details, glowing magical runes, epic cinematic composition',
    'dreamlike surreal scene with floating islands and waterfalls, ethereal lighting',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getCategoryIcon(String category) {
    switch (category) {
      case 'Portraits': return Icons.person_outline;
      case 'Landscapes': return Icons.nature_outlined;
      case 'Abstract': return Icons.palette_outlined;
      case 'Characters': return Icons.emoji_emotions_outlined;
      case 'Surreal': return Icons.straight_out_of_computer_outlined;
      default: return Icons.format_list_bulleted_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Gallery'),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 16),
          tabs: categories.map((category) => Tab()).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All prompts tab - show all categories
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: isDark ? Constants.cardElevation : 0,
                child: ListTile(
                  leading: Icon(Icons.palette, color: Constants.primaryColor),
                  title: Text('Prompt #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(
                        label: Text('✨ Free'),
                        backgroundColor: Colors.green.withOpacity(0.3),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.download),
                        tooltip: 'Use this prompt',
                        onPressed: () => _usePrompt(samplePrompts[index]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Portraits category
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length ~/ 2,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.person, color: Constants.primaryColor),
                  title: Text('Portrait #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[index % samplePrompts.length],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Chip(label: const Text('Portrait')),
                ),
              );
            },
          ),

          // Landscapes category
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length ~/ 2,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.nature, color: Constants.primaryColor),
                  title: Text('Landscape #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[(index % samplePrompts.length) + 2],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Chip(label: const Text('Landscape')),
                ),
              );
            },
          ),

          // Abstract category
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length ~/ 2,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.palette, color: Constants.primaryColor),
                  title: Text('Abstract #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[(index % samplePrompts.length) + 4],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Chip(label: const Text('Abstract')),
                ),
              );
            },
          ),

          // Characters category
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length ~/ 2,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.emoji_emotions, color: Constants.primaryColor),
                  title: Text('Character #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[(index % samplePrompts.length) + 3],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Chip(label: const Text('Character')),
                ),
              );
            },
          ),

          // Surreal category
          ListView.builder(
            padding: const EdgeInsets.all(Constants.spacingLarge),
            itemCount: samplePrompts.length ~/ 2,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.straight_out_of_computer, color: Constants.primaryColor),
                  title: Text('Surreal #${index + 1}'),
                  subtitle: SizedBox(
                    width: 250,
                    child: Text(
                      samplePrompts[(index % samplePrompts.length) + 4],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Chip(label: const Text('Surreal')),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  void _usePrompt(String prompt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromptDetailScreen(prompt: prompt),
      ),
    );
  }
}

/// Prompt Detail Screen - View and copy a single prompt
class PromptDetailScreen extends StatelessWidget {
  final String prompt;

  const PromptDetailScreen({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: Constants.spacingMedium,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette_rounded),
                        const SizedBox(width: 8),
                        Text('✨ AI Prompt'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      initialValue: prompt,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Constants.borderRadius),
                        ),
                        filled: true,
                        hintText: 'Your generated AI prompt',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Copy to clipboard
            ElevatedButton.icon(
              onPressed: () {
                // Copy prompt to clipboard logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Prompt copied to clipboard!')),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy to Clipboard'),
            ),

            const SizedBox(height: 16),
            
            // Use in generation
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Return to generation screen with prompt filled
              },
              icon: Icon(Icons.auto_fix_normal),
              label: const Text('Use in Generator'),
            ),
          ],
        ),
      ),
    );
  }
}
