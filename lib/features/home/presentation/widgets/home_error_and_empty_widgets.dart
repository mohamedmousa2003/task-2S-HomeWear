import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/values/app_strings.dart';
import '../manager/home_cubit/home_cubit.dart';

class HomeErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String dbName;
  final int uid;
  final String password;

  const HomeErrorWidget({
    super.key,
    required this.errorMessage,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: AppTextStyles.font16BoldDark,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     context.read<HomeCubit>().fetchCustomers(
            //       dbName: dbName,
            //       uid: uid,
            //       password: password,
            //     );
            //   },
            //   child: Text(
            //     AppStrings.tryAgain,
            //     style: AppTextStyles.font16SemiBoldWhite,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.noClientsMatchSearch,
        style: AppTextStyles.font16BoldDark,
      ),
    );
  }
}