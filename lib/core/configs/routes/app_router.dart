import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:glassify_flutter/presentation/transaction/pages/transaction_page.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/about/pages/about_page.dart';
import '../../../presentation/cart/page/cart_page.dart';
import '../../../presentation/menu/page/menu_page.dart';
import '../../../presentation/home/page/home_page.dart';
import '../../../presentation/onboarding/page/onboarding_page.dart';
import '../../../presentation/login/page/login_page.dart';
import '../../../presentation/register/page/register_page.dart';
import '../../../presentation/camera/page/camera_page.dart';
import '../../../presentation/camera_result/page/camera_result_page.dart';
import '../../../presentation/product/page/product_page.dart';
import '../../../presentation/splash/page/splash_page.dart';
import '../../../presentation/payment/page/payment_page.dart';
import '../../../presentation/payment_failed/page/payment_failed_page.dart';
import '../../../presentation/payment_result/page/payment_result_page.dart';
import '../../../presentation/product_review/page/product_review_page.dart';
import '../../../presentation/search/page/search_page.dart';
import '../../../presentation/search_result/page/search_result_page.dart';

import '../../../presentation/wishlist/pages/wishlist_page.dart';
import '../../configs/routes/app_routes.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _parentKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _parentKey,
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.cart,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const CartPage(),
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
        path: AppRoutes.about,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const AboutPage(),
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
        path: AppRoutes.menu,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const MenuPage(),
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
            child: const CameraPage(),
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
      GoRoute(
        path: AppRoutes.product,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: ProductPage(id: id),
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
        path: AppRoutes.productReview,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: ProductReviewPage(id: id),
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
        path: AppRoutes.payment,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: PaymentPage(id: id),
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
        path: AppRoutes.paymentResult,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: PaymentResultPage(id: id),
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
        path: AppRoutes.transaction,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const TransactionPage(),
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
        path: AppRoutes.paymentFailed,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const PaymentFailedPage(),
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
        path: AppRoutes.search,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const SearchPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.searchResult,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String query = state.extra as String;
          return NoTransitionPage(
            key: state.pageKey,
            child: SearchResultPage(query: query),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.cameraResult,
        builder: (BuildContext context, GoRouterState state) {
          final XFile picture = GoRouterState.of(context).extra! as XFile;
          return CameraResultPage(picture: picture);
        },
      ),
      GoRoute(
        path: AppRoutes.wishlist,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: Durations.medium1,
            child: const WishlistPage(),
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
    ],
  );
}
