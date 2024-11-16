import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/routes/app_routes.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(DisplaySplash()),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is FirstTimeState) {
                context.go(AppRoutes.onboarding);
              } else if (state is NotFirstTimeState) {
                context.go(AppRoutes.home);
              }
            },
            child: const Center(
              // TODO: Change with app logo
              child: Text('Splash Page'),
            ),
          ),
        ),
      ),
    );
  }
}
