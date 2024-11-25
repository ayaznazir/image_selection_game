import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../constants/layout_constants.dart';
import '../constants/string_constants.dart';
import '../controllers/game_controller.dart';

class ResultScreen extends StatelessWidget {
  final gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        elevation: LayoutConstants.cardElevation,
        title: const Text(
          StringConstants.resultsTitle,
          style: TextStyle(
            color: ColorConstants.background,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: LayoutConstants.defaultSpacing * 2),
              _buildResults(),
              const SizedBox(height: LayoutConstants.defaultSpacing * 2),
              _buildRestartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: ColorConstants.overlayDark,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        StringConstants.testComplete,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorConstants.background,
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: AppConstants.totalPages,
        itemBuilder: (context, index) => _buildResultItem(index),
      ),
    );
  }

  Widget _buildResultItem(int index) {
    print(
        'Page ${index + 1} attempts: ${gameController.pages[index].attempts}');
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: LayoutConstants.defaultMargin,
      ),
      padding: const EdgeInsets.all(LayoutConstants.defaultPadding),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: ColorConstants.overlayDark,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${StringConstants.pageResult} ${index + 1} :  ${gameController.pages[index].attempts} attempts",
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorConstants.textPrimary,
                ),
              ),
            ],
          ),
          Icon(
            gameController.pages[index].attempts <= 2
                ? Icons.check_circle
                : Icons.error,
            color: gameController.pages[index].attempts <= 2
                ? ColorConstants.success
                : ColorConstants.error,
          ),
        ],
      ),
    );
  }

  Widget _buildRestartButton() {
    return ElevatedButton(
      onPressed: gameController.restart,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.defaultPadding * 2,
          vertical: LayoutConstants.defaultPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.borderRadius),
        ),
      ),
      child: const Text(
        StringConstants.restartButton,
        style: TextStyle(
          color: ColorConstants.background,
          fontSize: 18,
        ),
      ),
    );
  }
}
