import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2shomewear/config/route_manager/routes.dart';
import 'package:task2shomewear/features/home/presentation/pages/home.dart';
import 'package:task2shomewear/features/splash/splash_screen.dart';
import '../../features/login/presentation/manager/login/login_cubit.dart';
import '../../features/login/presentation/pages/login/login_screen.dart';
import '../../core/values/app_strings.dart';
import '../di/di.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {

        ///? Splash Screen
        case Routes.splashRoute:
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
      /// Login Screen
        case Routes.loginRoute:
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt.get<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );

      /// Home Screen
        case Routes.homeRoute:
          final args = settings.arguments as Map<String, dynamic>?;
          return CupertinoPageRoute(
            builder: (_) => HomeScreen(
              dbName: args?['dbName'] ?? '',
              uid: args?['uid'] ?? 0,
              password: args?['password'] ?? '',
            ),
          );

      /// Default (Unknown Route)
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(AppStrings.pageNotFound, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}