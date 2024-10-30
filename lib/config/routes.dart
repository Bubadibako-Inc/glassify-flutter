import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:glassify_flutter/constants/route_name.dart';
import 'package:glassify_flutter/onboarding/page/onboarding_page.dart';

class Routes {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RouteName.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      GoRoute(
        path: RouteName.home,
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
