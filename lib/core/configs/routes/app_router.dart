import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/routes/app_routes.dart';

import '../../../onboarding/page/onboarding_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: Center(
              child: Text('Home Page'),
            ),
          );
        },
      ),
    ],
  );
}
