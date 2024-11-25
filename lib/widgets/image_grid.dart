import 'package:flutter/material.dart';
import '../models/game_image.dart';
import '../constants/layout_constants.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

class ImageGrid extends StatelessWidget {
  final List<GameImage> images;
  final List<int> wrongAttempts;
  final Function(int) onImageTap;

  const ImageGrid({
    Key? key,
    required this.images,
    required this.wrongAttempts,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(LayoutConstants.gridPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: LayoutConstants.gridColumns,
        crossAxisSpacing: LayoutConstants.gridSpacing,
        mainAxisSpacing: LayoutConstants.gridSpacing,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) => _buildImageCard(index),
    );
  }

  Widget _buildImageCard(int index) {
    print('Loading image: ${images[index].imagePath}');
    return Card(
      elevation: LayoutConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadius),
      ),
      child: GestureDetector(
        onTap: () => onImageTap(index),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(LayoutConstants.borderRadius),
              child: Image.asset(
                images[index].imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: ${images[index].imagePath}');
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.error.withOpacity(0.3),
                      borderRadius:
                          BorderRadius.circular(LayoutConstants.borderRadius),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: ColorConstants.error,
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image not found',
                            style: TextStyle(
                              color: ColorConstants.error,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (wrongAttempts.contains(index))
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.error
                      .withOpacity(ColorConstants.overlayOpacity),
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.borderRadius),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: ColorConstants.background,
                    size: LayoutConstants.wrongMarkSize,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
