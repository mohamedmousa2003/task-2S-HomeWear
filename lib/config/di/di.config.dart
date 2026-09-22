// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/home/api/api_client_home.dart' as _i758;
import '../../features/home/api/data_source/local/customer_list_local_data_source_impl.dart'
    as _i392;
import '../../features/home/api/data_source/remote/customer_list_remote_data_source_impl.dart'
    as _i430;
import '../../features/home/data/data_source/customer_list_remote_data_source.dart'
    as _i327;
import '../../features/home/data/data_source/local/customer_list_local_data_source.dart'
    as _i1034;
import '../../features/home/data/repositories/customer_repo_impl.dart' as _i224;
import '../../features/home/domain/repositories/customer_repo.dart' as _i1018;
import '../../features/home/domain/use_case/customer_details_use_case.dart'
    as _i523;
import '../../features/home/domain/use_case/update_customer_phone_use_case.dart'
    as _i36;
import '../../features/home/presentation/manager/details_cubit/customer_details_cubit.dart'
    as _i396;
import '../../features/home/presentation/manager/home_cubit/home_cubit.dart'
    as _i535;
import '../../features/login/api/api_client_auth_login.dart' as _i35;
import '../../features/login/api/data_source/remote/auth_remote_data_source_impl.dart'
    as _i171;
import '../../features/login/data/data_source/remote/auth_remote_data_source.dart'
    as _i844;
import '../../features/login/data/repositories/auth_repo_impl.dart' as _i251;
import '../../features/login/domain/repositories/auth_repo.dart' as _i295;
import '../../features/login/domain/use_case/login_use_case.dart' as _i168;
import '../../features/login/presentation/manager/login/login_cubit.dart'
    as _i441;
import '../../features/sales_orders/api/api_client_sales_orders.dart' as _i924;
import '../../features/sales_orders/api/data_source/sales_orders_remote_data_source_impl.dart'
    as _i474;
import '../../features/sales_orders/data/data_source/sales_orders_remote_data_source.dart'
    as _i167;
import '../../features/sales_orders/data/repositories/sales_orders_repository_impl.dart'
    as _i373;
import '../../features/sales_orders/domain/repositories/sales_orders_repository.dart'
    as _i786;
import '../../features/sales_orders/domain/use_case/check_internal_user_use_case.dart'
    as _i54;
import '../../features/sales_orders/domain/use_case/confirm_sale_order_use_case.dart'
    as _i912;
import '../../features/sales_orders/domain/use_case/get_sale_orders_use_case.dart'
    as _i608;
import '../../features/sales_orders/presentation/cubit/sale_order/sale_order_cubit.dart'
    as _i513;
import '../local_storage/hive_storage.dart' as _i1023;
import '../local_storage/local_storage.dart' as _i226;
import '../module/api_module.dart' as _i235;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => apiModule.providerDioLogger(),
    );
    gh.factory<_i1034.CustomerListLocalDataSource>(
      () => _i392.CustomerListLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i226.LocalStorage>(() => _i1023.HiveStorage());
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.factory<_i758.ApiClientHome>(() => _i758.ApiClientHome(gh<_i361.Dio>()));
    gh.factory<_i35.ApiClientAuthLogin>(
      () => _i35.ApiClientAuthLogin(gh<_i361.Dio>()),
    );
    gh.factory<_i924.ApiClientSalesOrders>(
      () => _i924.ApiClientSalesOrders(gh<_i361.Dio>()),
    );
    gh.factory<_i167.SalesOrdersRemoteDataSource>(
      () => _i474.SalesOrdersRemoteDataSourceImpl(
        gh<_i924.ApiClientSalesOrders>(),
      ),
    );
    gh.factory<_i327.CustomerListRemoteDataSource>(
      () => _i430.CustomerListRemoteDataSourceImpl(gh<_i758.ApiClientHome>()),
    );
    gh.factory<_i844.AuthRemoteDataSource>(
      () => _i171.AuthRemoteDataSourceImpl(gh<_i35.ApiClientAuthLogin>()),
    );
    gh.factory<_i1018.CustomerRepository>(
      () => _i224.CustomerRepositoryImpl(
        gh<_i327.CustomerListRemoteDataSource>(),
        gh<_i1034.CustomerListLocalDataSource>(),
      ),
    );
    gh.factory<_i295.AuthRepo>(
      () => _i251.AuthRepoImpl(gh<_i844.AuthRemoteDataSource>()),
    );
    gh.factory<_i786.SalesOrdersRepository>(
      () => _i373.SalesOrdersRepositoryImpl(
        gh<_i167.SalesOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i168.LoginUseCase>(
      () => _i168.LoginUseCase(gh<_i295.AuthRepo>()),
    );
    gh.factory<_i441.LoginCubit>(
      () => _i441.LoginCubit(gh<_i168.LoginUseCase>()),
    );
    gh.factory<_i523.GetCustomersUseCase>(
      () => _i523.GetCustomersUseCase(gh<_i1018.CustomerRepository>()),
    );
    gh.factory<_i36.UpdateCustomerPhoneUseCase>(
      () => _i36.UpdateCustomerPhoneUseCase(gh<_i1018.CustomerRepository>()),
    );
    gh.factory<_i535.HomeCubit>(
      () => _i535.HomeCubit(gh<_i523.GetCustomersUseCase>()),
    );
    gh.factory<_i54.CheckInternalUserUseCase>(
      () => _i54.CheckInternalUserUseCase(gh<_i786.SalesOrdersRepository>()),
    );
    gh.factory<_i912.ConfirmSaleOrderUseCase>(
      () => _i912.ConfirmSaleOrderUseCase(gh<_i786.SalesOrdersRepository>()),
    );
    gh.factory<_i608.GetSaleOrdersUseCase>(
      () => _i608.GetSaleOrdersUseCase(gh<_i786.SalesOrdersRepository>()),
    );
    gh.factory<_i396.CustomerDetailsCubit>(
      () => _i396.CustomerDetailsCubit(gh<_i36.UpdateCustomerPhoneUseCase>()),
    );
    gh.factory<_i513.SalesOrdersCubit>(
      () => _i513.SalesOrdersCubit(
        gh<_i608.GetSaleOrdersUseCase>(),
        gh<_i912.ConfirmSaleOrderUseCase>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i235.ApiModule {}
