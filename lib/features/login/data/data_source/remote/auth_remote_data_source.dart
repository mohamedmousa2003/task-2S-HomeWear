import 'package:task2shomewear/features/login/data/model/response/login_response.dart';
import '../../../../../config/error_handling/result.dart';

abstract interface class AuthRemoteDataSource {
  Future<Result<LoginResponse>> login({
    required String email,
    required String password,
  });


}



