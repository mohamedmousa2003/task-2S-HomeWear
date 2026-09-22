import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2shomewear/core/utils/app_text_styles.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/values/app_strings.dart';
import '../manager/home_cubit/home_cubit.dart';

class CustomerSearchBar extends StatefulWidget {
  const CustomerSearchBar({super.key});

  @override
  State<CustomerSearchBar> createState() => _CustomerSearchBarState();
}

class _CustomerSearchBarState extends State<CustomerSearchBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 16, vertical: 10),
      child: TextFormField(
        controller: _searchController,
        onChanged: (query) {
          context.read<HomeCubit>().searchCustomers(query);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: AppStrings.searchName,
          hintStyle: AppTextStyles.font16BoldDark,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<HomeCubit>().searchCustomers('');
              setState(() {});
            },
          )
              : null,
          filled: true,
          fillColor: AppColors.textFormFile,

          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(value: 15),
            ),
            borderSide: BorderSide(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}