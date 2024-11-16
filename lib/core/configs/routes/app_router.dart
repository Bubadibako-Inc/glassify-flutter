import 'package:flutter/material.dart';
import 'package:glassify_flutter/presentation/camera/page/camera_page.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/splash/page/splash_page.dart';
import '../../configs/routes/app_routes.dart';

import '../../../presentation/cart/page/cart_page.dart';
import '../../../presentation/menu/page/menu_page.dart';
import '../../../presentation/home/page/home_page.dart';
import '../../../presentation/onboarding/page/onboarding_page.dart';
import '../../../presentation/login/page/login_page.dart';
import '../../../presentation/register/page/register_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _parentKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _parentKey,
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.cart,
        builder: (BuildContext context, GoRouterState state) {
          return const CartPage();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.menu,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: MenuPage(),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation, _, Widget child) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(0.75, 0),
                    end: Offset.zero,
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: AppRoutes.camera,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: CameraPage(),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation, _, Widget child) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(0.75, 0),
                    end: Offset.zero,
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
    ],
  );
}
