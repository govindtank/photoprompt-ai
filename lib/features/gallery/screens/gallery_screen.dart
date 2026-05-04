import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../../splash/screens/splash_screen.dart';
import './gallery_item_widget.dart';

/// Gallery Screen - Browse all generated images
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh gallery - re-fetch from cache
              _showSnackBar('Gallery refreshed!');
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              _confirmClearAll(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Column(
          children: [
            // Filter/Sort Bar
            Container(
              padding: Constants.spacingMedium,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          _buildFilterChip('All', 'all'),
                          const SizedBox(width: 8),
                          _buildFilterChip('Favorites', 'favorites'),
                          const SizedBox(width: 8),
                          _buildFilterChip('Newest', 'newest'),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // Grid View
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Column(
                  children: [
                    // Tab Bar
                    TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Grid'),
                        Tab(text: 'List'),
                      ],
                    ),
                    
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Grid View (default)
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                            itemCount: 10, // Sample items - replace with actual cache data
                            itemBuilder: (context, index) => GalleryItemWidget(
                              index: index,
                              imageUrl: 'https://picsum.photos/512/512?random=$index',
                              isFavorite: false,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDetailScreen(
                                      imageUrl: 'https://picsum.photos/512/512?random=$index',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          // List View
                          ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => GalleryItemWidget(
                              index: index,
                              imageUrl: 'https://picsum.photos/512/512?random=$index',
                              isFavorite: false,
                              showActions: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDetailScreen(
                                      imageUrl: 'https://picsum.photos/512/512?random=$index',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => print('Selected: $label'),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: Constants.spacingMedium,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Gallery'),
        content: Text('Are you sure you want to clear all cached images? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              _showSnackBar('Gallery cleared!');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Gallery Item Widget - Individual image card in grid/list view
class GalleryItemWidget extends StatelessWidget {
  final int index;
  final String imageUrl;
  final bool isFavorite;
  final bool showActions;
  final VoidCallback onTap;

  const GalleryItemWidget({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.isFavorite,
    this.showActions = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image Loader
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.grey[800],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.red[100],
                child: Icon(Icons.error_outline),
              ),
            ),

            // Favorite Heart (if favorite)
            if (isFavorite) ...[
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],

            // Overlay Gradient (for better text visibility)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Image Detail Screen - View generated image with metadata
class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => _showSnackBar('Added to favorites!'),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _navigateToGallery(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.grey[800],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.red[100],
                child: Icon(Icons.error_outline),
              ),
            ),
          ),
          
          // Overlay for actions
          Positioned(
            top: 80,
            right: 8,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.share),
                  tooltip: 'Share',
                  onPressed: () => _showSnackBar('Image shared!'),
                ),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.download),
                  tooltip: 'Download',
                  onPressed: () => _showSnackBar('Downloading...'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToGallery(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GalleryScreen()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
