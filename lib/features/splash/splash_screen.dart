import 'package:flutter/material.dart';
import 'package:task2shomewear/config/cache/secure_cache/cache_keys.dart';
import 'package:task2shomewear/config/cache/secure_cache/secure_cache_helper.dart';
import 'package:task2shomewear/config/route_manager/routes.dart';
import 'package:task2shomewear/core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final rememberMe = await SecureCacheHelper.getData(
      key: CacheKeys.rememberMe,
    );

    final userId = await SecureCacheHelper.getData(
      key: CacheKeys.userId,
    );

    final password = await SecureCacheHelper.getData(
      key: CacheKeys.password,
    );

    if (!mounted) return;

    final isRemembered = rememberMe == 'true';

    if (isRemembered &&
        userId != null &&
        password != null &&
        password.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.homeRoute,
            (route) => false,
        arguments: {
          'dbName': 'odoo_flutter',
          'uid': int.parse(userId),
          'password': password,
        },
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logoImage,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}