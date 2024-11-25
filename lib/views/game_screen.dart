import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../constants/layout_constants.dart';
import '../constants/string_constants.dart';
import '../controllers/game_controller.dart';
import '../widgets/image_grid.dart';
import '../widgets/animation_overlay.dart';

class GameScreen extends StatelessWidget {
  final gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        elevation: LayoutConstants.cardElevation,
        title: Obx(() => Text(
              '${StringConstants.pageTitle} ${gameController.currentPageIndex.value + 1}/${AppConstants.totalPages}',
              style: const TextStyle(
                color: ColorConstants.background,
                fontSize: 20,
              ),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: ColorConstants.background),
            onPressed: gameController.restart,
            tooltip: StringConstants.restartButton,
            padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next, color: ColorConstants.background),
            onPressed: gameController.nextPage,
            tooltip: StringConstants.nextButton,
            padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
          child: Stack(
            children: [
              Obx(() => ImageGrid(
                    images: gameController
                        .pages[gameController.currentPageIndex.value].images,
                    wrongAttempts: gameController
                        .pages[gameController.currentPageIndex.value]
                        .wrongAttempts,
                    onImageTap: gameController.checkAnswer,
                  )),
              Obx(() => AnimationOverlay(
                    showSuccess: gameController.showSuccessAnimation.value,
                    showFailure: gameController.showFailureAnimation.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
