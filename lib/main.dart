import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من وجود هذا الـ Import
import 'package:task2shomewear/config/local_storage/lib/config/local_storage/hive_config.dart';
import 'config/di/di.dart';
import 'config/local_storage/local_storage.dart';
import 'config/route_manager/route_generator.dart';
import 'config/route_manager/routes.dart';
import 'core/helpers/custom_bloc_observer.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await getIt<LocalStorage>().init();
  await HiveConfig.init();
  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme(context),
          initialRoute: Routes.splashRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}

///? admin@gmail.com