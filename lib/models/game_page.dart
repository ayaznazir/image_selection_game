import 'game_image.dart';

class GamePage {
  final List<GameImage> images;
  final int correctImageIndex;
  int attempts;
  List<int> wrongAttempts;

  GamePage({
    required this.images,
    required this.correctImageIndex,
    this.attempts = 0,
    List<int>? wrongAttempts,
  }) : wrongAttempts = wrongAttempts ?? [];

  bool isCompleted = false;
}
