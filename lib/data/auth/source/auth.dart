import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/dio_clint.dart';
import 'package:ecommerce_app/data/auth/model/auth.dart';
import 'package:ecommerce_app/data/auth/model/login_response.dart';
import 'package:ecommerce_app/service_locator.dart';

abstract class AuthSource {
  Future<Either> login(LoginRequest loginRequest);
}

class AuthSourceImpl extends AuthSource {
  @override
  Future<Either> login(LoginRequest loginRequest) async {
    try {
      var response = await sl<DioClient>().post(
        "user/login", // baseURL should already be `https://dummyjson.com`
        data: loginRequest.toJson(),
      );

      // Inspect response before parsing it
      print('Response data: ${response.data}');

      if (response.data != null) {
        // Assuming `response.data` is a map
        final loginResponse = LoginResponse.fromJson(response.data);

        // Save token if needed
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', loginResponse.accessToken);

        return Right(loginResponse);
      } else {
        return Left("No data received.");
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? "Something went wrong";
      return Left(message.toString());
    }
  }
}
