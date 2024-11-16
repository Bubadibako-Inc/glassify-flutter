import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/data/auth/models/login_req_params.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bloc/auth_bloc.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_button.dart';
import '../../../common/widgets/error_text_field.dart';
import '../../../common/widgets/message.dart';

import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Column _message() {
    return Column(
      children: [
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is FailedState) {
              return Column(
                children: [
                  Message(
                    color: AppColors.red100,
                    borderColor: AppColors.red300,
                    icon: AppIcons.warningCircle,
                    iconColor: AppColors.red500,
                    text: state.message,
                    style: const TextStyle(
                      color: AppColors.red500,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSpacer(height: 16),
                ],
              );
            }

            if (state is SuccessState) {
              return const Column(
                children: [
                  Message(
                    color: AppColors.green100,
                    borderColor: AppColors.green300,
                    icon: AppIcons.warningCircle,
                    iconColor: AppColors.green500,
                    text: 'Berhasil melakukan login!',
                    style: TextStyle(
                      color: AppColors.green500,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  VerticalSpacer(height: 16),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        BlocProvider(
          create: (_) => AuthBloc()..add(GetToken()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            context.pop();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image(),
                  const VerticalSpacer(height: 16),
                  _titleText(),
                  const VerticalSpacer(height: 2),
                  _subtitleText(),
                  const VerticalSpacer(height: 16),
                  _message(),
                  _emailField(),
                  const VerticalSpacer(height: 16),
                  _passwordField(),
                  const VerticalSpacer(height: 16),
                  _loginButton(),
                  const VerticalSpacer(height: 12),
                  _registerText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _image() {
    return Container(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppImages.login,
        width: 390,
      ),
    );
  }

  Text _titleText() {
    return const Text(
      'Login',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: AppColors.black,
      ),
    );
  }

  Text _subtitleText() {
    return const Text(
      'Masuk menggunakan akun Glassify yang sudah terdaftar',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.neutral500,
        fontSize: 16,
      ),
    );
  }

  AppTextField _emailField() {
    return AppTextField(
      controller: _emailController,
      prefixIcon: Container(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset(
            AppIcons.envelopeOpen,
            height: 16,
            width: 16,
          ),
        ),
      ),
      hintText: 'Email',
      // error: 'Error ngabs',
    );
  }

  AppTextField _passwordField() {
    return AppTextField(
      controller: _passwordController,
      prefixIcon: Container(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset(
            AppIcons.password,
            height: 16,
            width: 16,
          ),
        ),
      ),
      suffixIcon: Container(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset(
            AppIcons.eye,
            height: 16,
            width: 16,
          ),
        ),
      ),
      hintText: 'Password',
    );
  }

  SizedBox _registerText(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Belum memiliki akun?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.neutral500,
            ),
          ),
          const HorizontalSpacer(width: 4),
          AppTextButton(
            onTap: () => context.pushReplacement(AppRoutes.register),
            text: 'Daftar',
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Container(
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return AppButton(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          boxDecoration: const BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          onTap: () => BlocProvider.of<LoginBloc>(context).add(
            OnButtonPressed(
              params: LoginReqParams(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}

class AppTextField extends StatelessWidget {
  final Widget prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? error;

  const AppTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        error: error == null
            ? null
            : ErrorTextField(
                text: error!,
              ),
      ),
    );
  }
}