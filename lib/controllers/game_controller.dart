import 'package:get/get.dart';
import '../models/game_page.dart';
import '../models/game_image.dart';
import '../constants/image_constants.dart';
import 'dart:math';

class GameController extends GetxController {
  final currentPageIndex = 0.obs;
  final pages = <GamePage>[].obs;
  final isCompleted = false.obs;
  final showSuccessAnimation = false.obs;
  final showFailureAnimation = false.obs;

  final _random = Random();

  @override
  void onInit() {
    super.onInit();
    initializeGame();
  }

  void initializeGame() {
    pages.value = List.generate(3, (pageIndex) {
      List<GameImage> pageImages = [];

      List<String> available2DImages =
          List<String>.from(ImageConstants.all2DImages);
      available2DImages.shuffle(_random);

      for (int i = 0; i < 8; i++) {
        String imagePath = available2DImages[i];
        pageImages.add(GameImage(
          imagePath: imagePath,
          is3D: false,
          name: 'Image ${i + 1}',
        ));
      }

      List<String> available3DImages =
          List<String>.from(ImageConstants.all3DImages);
      String random3DImage =
          available3DImages[_random.nextInt(available3DImages.length)];

      pageImages.add(GameImage(
        imagePath: random3DImage,
        is3D: true,
        name: '3D Image',
      ));

      pageImages.shuffle(_random);

      return GamePage(
        images: pageImages,
        correctImageIndex: pageImages.indexWhere((img) => img.is3D),
      );
    });

    currentPageIndex.value = 0;
    isCompleted.value = false;
  }

  void checkAnswer(int selectedIndex) async {
    final currentPage = pages[currentPageIndex.value];

    currentPage.attempts++;
    print(
        'Current Page: ${currentPageIndex.value + 1}, Attempts: ${currentPage.attempts}');

    if (currentPage.correctImageIndex == selectedIndex) {
      showSuccessAnimation.value = true;
      await Future.delayed(const Duration(milliseconds: 1500));
      showSuccessAnimation.value = false;

      currentPage.isCompleted = true;

      if (currentPageIndex.value < 2) {
        currentPageIndex.value++;
      } else {
        isCompleted.value = true;
        Get.toNamed('/results');
      }
    } else {
      currentPage.wrongAttempts.add(selectedIndex);
      showFailureAnimation.value = true;
      await Future.delayed(const Duration(milliseconds: 1500));
      showFailureAnimation.value = false;
    }
    update();
  }

  void nextPage() {
    if (currentPageIndex.value < 2) {
      currentPageIndex.value++;
    }
  }

  void restart() {
    initializeGame();
    Get.offAllNamed('/');
  }

  int getTotalAttempts(int pageIndex) {
    return pages[pageIndex].attempts;
  }
}
