import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2shomewear/config/di/di.dart';
import 'package:task2shomewear/core/utils/app_colors.dart';
import 'package:task2shomewear/core/values/app_strings.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
import 'package:task2shomewear/features/home/presentation/manager/details_cubit/customer_details_cubit.dart';
import 'package:task2shomewear/features/home/presentation/manager/details_cubit/customer_details_state.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerEntity customer;
  final String dbName;
  final int uid;
  final String password;

  const CustomerDetailsScreen({
    super.key,
    required this.customer,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  State<CustomerDetailsScreen> createState() =>
      _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  late final TextEditingController _phoneController;

  bool _hasChanges = false;
  bool _isUpdated = false;
  String get _initialPhone {
    if (widget.customer.phone == 'Not Available') {
      return '';
    }

    return widget.customer.phone;
  }

  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController(
      text: _initialPhone,
    );

    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final currentPhone = _phoneController.text.trim();

    final hasChanges = currentPhone != _initialPhone.trim();

    if (_hasChanges != hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  void _updatePhone(BuildContext context) {
    context.read<CustomerDetailsCubit>().updateCustomerPhone(
      dbName: widget.dbName,
      uid: widget.uid,
      password: widget.password,
      customerId: widget.customer.id,
      phone: _phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerDetailsCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<CustomerDetailsCubit, CustomerDetailsState>(
            listener: (context, state) {
              if (state is CustomerDetailsUpdateSuccessState) {
                setState(() {
                  _hasChanges = false;
                  _isUpdated = true;
                });

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Phone number updated successfully',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }

              if (state is CustomerDetailsUpdateFailureState) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFF7F8FC),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                centerTitle: true,

                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context, _isUpdated);
                  },
                ),

                title: const Text(
                  AppStrings.customerDetails,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CustomerHeader(
                        customer: widget.customer,
                      ),

                      const SizedBox(height: 24),

                      const _SectionTitle(
                        title: 'Customer Information',
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 12),

                      _CustomerInfoCard(
                        customer: widget.customer,
                      ),

                      const SizedBox(height: 24),

                      const _SectionTitle(
                        title: 'Update Phone Number',
                        icon: Icons.phone_outlined,
                      ),

                      const SizedBox(height: 12),

                      _PhoneUpdateCard(
                        controller: _phoneController,
                      ),

                      const SizedBox(height: 24),

                      BlocBuilder<
                          CustomerDetailsCubit,
                          CustomerDetailsState>(
                        builder: (context, state) {
                          final isLoading =
                          state is CustomerDetailsUpdateLoadingState;

                          final canSave =
                              _hasChanges && !isLoading;

                          return SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: canSave
                                  ? () => _updatePhone(context)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                disabledBackgroundColor:
                                Colors.grey.shade300,
                                disabledForegroundColor:
                                Colors.grey.shade500,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                                  : const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.save_rounded,
                                    size: 21,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Save Changes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      const Center(
                        child: Text(
                          'Changes will be saved directly to Odoo',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8A8F9C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CustomerHeader extends StatelessWidget {
  final CustomerEntity customer;

  const _CustomerHeader({
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    final name = customer.name.trim();

    final firstLetter = name.isNotEmpty
        ? name.substring(0, 1).toUpperCase()
        : '?';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                firstLetter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            customer.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 6),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Customer #${customer.id}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

class _CustomerInfoCard extends StatelessWidget {
  final CustomerEntity customer;

  const _CustomerInfoCard({
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE9EBF0),
        ),
      ),
      child: Column(
        children: [
          _InfoItem(
            icon: Icons.person_outline_rounded,
            title: 'Name',
            value: customer.name,
          ),

          const _InfoDivider(),

          _InfoItem(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: customer.phone,
          ),

          const _InfoDivider(),

          _InfoItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: customer.email,
          ),

          const _InfoDivider(),

          _InfoItem(
            icon: Icons.location_on_outlined,
            title: 'Address',
            value: customer.city,
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 21,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8A8F9C),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF252A34),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        height: 1,
        color: Color(0xFFF0F1F4),
      ),
    );
  }
}

class _PhoneUpdateCard extends StatelessWidget {
  final TextEditingController controller;

  const _PhoneUpdateCard({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE9EBF0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter phone number',
              hintStyle: const TextStyle(
                color: Color(0xFFB0B5BF),
              ),
              prefixIcon: Icon(
                Icons.phone_rounded,
                color: AppColors.primary,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F9FC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE6E8ED),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 15,
                color: Color(0xFF8A8F9C),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Enter the new phone number and save your changes.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8A8F9C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}