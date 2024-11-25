import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constants/color_constants.dart';
import 'constants/string_constants.dart';
import 'views/game_screen.dart';
import 'views/result_screen.dart';
import 'constants/app_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConstants.appTitle,
      theme: ThemeData(
        primaryColor: ColorConstants.primary,
        scaffoldBackgroundColor: ColorConstants.background,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => GameScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/results',
          page: () => ResultScreen(),
          transition: Transition.fadeIn,
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
