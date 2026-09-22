import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2shomewear/config/route_manager/routes.dart';
import 'package:task2shomewear/core/helpers/app_snackbar.dart';
import 'package:task2shomewear/core/helpers/my_responsive.dart';
import 'package:task2shomewear/core/helpers/validator.dart';
import 'package:task2shomewear/core/shared_widgets/custom_button.dart';
import 'package:task2shomewear/core/utils/app_assets.dart';
import 'package:task2shomewear/core/utils/app_colors.dart';
import 'package:task2shomewear/core/utils/app_text_styles.dart';
import 'package:task2shomewear/core/values/app_strings.dart';
import 'package:task2shomewear/features/login/presentation/manager/login/login_cubit.dart';
import 'package:task2shomewear/features/login/presentation/manager/login/login_state.dart';
import 'package:task2shomewear/features/login/presentation/widgets/remember_me_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validate(LoginCubit cubit) {
    final isValid = formKey.currentState?.validate() ?? false;

    cubit.validateForm(isValid);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) {
          return current is LoginSuccessState ||
              current is LoginFailureState;
        },
        buildWhen: (previous, current) {
          return previous is LoginLoadingState !=
              current is LoginLoadingState ||
              previous.isFormValid != current.isFormValid ||
              previous.rememberMe != current.rememberMe;
        },
        listener: (context, state) {
          if (state is LoginSuccessState) {
            AppSnackPar.success(
              context,
              'Login Success',
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.homeRoute,
                  (route) => false,
              arguments: {
                'dbName': 'odoo_flutter',
                'uid': state.userId,
                'password': passwordController.text.trim(),
              },
            );
          }

          if (state is LoginFailureState) {
            AppSnackPar.error(
              context,
              state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is LoginLoadingState;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MyResponsive.width(
                  value: 16,
                ),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MyResponsive.height(
                        value: 80,
                      ),
                    ),

                    Image.asset(
                      AppAssets.logoImage,
                      height: 200,
                      width: 200,
                    ),

                    SizedBox(
                      height: MyResponsive.height(
                        value: 20,
                      ),
                    ),

                    Text(
                      AppStrings.login,
                      style: AppTextStyles.font24BoldPrimary(),
                    ),

                    SizedBox(
                      height: MyResponsive.height(
                        value: 12,
                      ),
                    ),

                    TextFormField(
                      controller: emailController,
                      onChanged: (_) => _validate(cubit),
                      validator: Validator.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.email,
                        hintText: AppStrings.enterYouEmail,
                      ),
                    ),

                    SizedBox(
                      height: MyResponsive.height(
                        value: 24,
                      ),
                    ),

                    TextFormField(
                      controller: passwordController,
                      onChanged: (_) => _validate(cubit),
                      validator: Validator.password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: AppStrings.password,
                        hintText: AppStrings.enterYouPassword,
                      ),
                    ),

                    SizedBox(
                      height: MyResponsive.height(
                        value: 10,
                      ),
                    ),

                    RememberMeAndForgetWidget(
                      value: state.rememberMe,
                      onChanged: (selected) {
                        cubit.changeRememberMe(
                          selected ?? false,
                        );
                      },
                    ),

                    SizedBox(
                      height: MyResponsive.height(
                        value: 40,
                      ),
                    ),

                    isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      title: AppStrings.login,
                      backgroundColor: state.isFormValid
                          ? AppColors.primary
                          : AppColors.grey,
                      onPressed: state.isFormValid
                          ? () {
                        cubit
                            .loginWithEmailAndPassword(
                          email:
                          emailController.text.trim(),
                          password:
                          passwordController.text.trim(),
                        );
                      }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}