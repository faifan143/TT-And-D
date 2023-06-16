import 'package:driver/core/constants/AppRoutes.dart';
import 'package:driver/core/middleware/myMiddleware.dart';
import 'package:driver/view/screens/login_screen.dart';
import 'package:driver/view/screens/map_tracking.dart';
import 'package:get/get.dart';

// Define a list of GetPages to represent all the app screens and their associated routes
List<GetPage<dynamic>>? pages = [
  // Language selection screen
  GetPage(
    name: "/", // Default route
    page: () => LoginScreen(), // Use Language screen as page
    middlewares: [
      MyLoginMiddleware()
    ], // Use the defined middlewares for this screen
  ),
  // Auth screens
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(
    name: AppRoutes.mainScreen,
    page: () => const MapTracking(),
  ),
  // App screens
];
