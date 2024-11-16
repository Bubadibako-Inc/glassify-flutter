import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/common/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_button.dart';
import '../../../common/widgets/message.dart';

import '../../../data/auth/models/register_req_params.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  void _navigateToLogin() {
    context.pushReplacement(AppRoutes.login);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(),
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
                  _registerImage(),
                  const VerticalSpacer(height: 16),
                  _titleText(),
                  const VerticalSpacer(height: 2),
                  _subtitleText(),
                  const VerticalSpacer(height: 16),
                  _message(),
                  _nameField(),
                  const VerticalSpacer(height: 16),
                  _emailField(),
                  const VerticalSpacer(height: 16),
                  _passwordField(),
                  const VerticalSpacer(height: 16),
                  _confirmPasswordField(),
                  const VerticalSpacer(height: 16),
                  _registerButton(),
                  const VerticalSpacer(height: 12),
                  _loginText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SvgPicture _registerImage() {
    return SvgPicture.asset(
      AppImages.register,
      width: 390,
    );
  }

  Text _titleText() {
    return const Text(
      'Register',
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
      'Daftar ke Glassify sekarang dengan membuat akun baru!',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.neutral500,
        fontSize: 16,
      ),
    );
  }

  Column _message() {
    return Column(
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
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
                    text: 'Berhasil daftar akun',
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

  AppTextField _nameField() {
    return AppTextField(
      controller: _nameController,
      prefixIcon: Container(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: SvgPicture.asset(
            AppIcons.user,
            height: 16,
            width: 16,
          ),
        ),
      ),
      hintText: 'Nama',
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

  AppTextField _confirmPasswordField() {
    return AppTextField(
      controller: _passwordConfirmController,
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
            AppIcons.eyeSlash,
            height: 16,
            width: 16,
          ),
        ),
      ),
      hintText: 'Konfirmasi Password',
    );
  }

  BlocBuilder _registerButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    'Register',
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
          onTap: () async => BlocProvider.of<RegisterBloc>(context).add(
            OnButtonPressed(
              params: RegisterReqParams(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
              ),
            ),
          ),
          child: const Text(
            'Daftar Akun',
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

  SizedBox _loginText() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sudah memiliki akun?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.neutral500,
            ),
          ),
          const HorizontalSpacer(width: 4),
          AppTextButton(
            onTap: _navigateToLogin,
            text: 'Login',
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
}

class AppTextField extends StatelessWidget {
  final Widget prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      controller: controller,
      cursorColor: AppColors.black,
      cursorErrorColor: AppColors.red500,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        fillColor: AppColors.neutral50,
        labelText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: const TextStyle(
          color: AppColors.black,
          fontSize: 16,
        ),
        labelStyle: const TextStyle(
          color: AppColors.neutral500,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.black,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.neutral300,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.red300,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.red500,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        // error: Container(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SvgPicture.asset(
        //         AppIcons.warningCircle,
        //         width: 16,
        //         height: 16,
        //         colorFilter: const ColorFilter.mode(
        //           AppColors.red500,
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //       const HorizontalSpacer(width: 4),
        //       const Text(
        //         'Error Ngabs',
        //         style: TextStyle(
        //           color: AppColors.red500,
        //           fontSize: 14,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
