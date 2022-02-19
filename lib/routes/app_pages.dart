import 'package:get/get.dart';
import '/bindings/bindings.dart';
import '/routes/app_routes.dart';
import '/screens/screens.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.connection,
      page: () => const ConnectionScreen(),
      binding: ConnectionBinding(),
    )
  ];
}
