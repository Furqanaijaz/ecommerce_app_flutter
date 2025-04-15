import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/auth/model/auth.dart';
import 'package:ecommerce_app/data/auth/model/login_response.dart';

abstract class AuthRepository {
  Future<Either> login(LoginRequest loginRequest);
  Future<bool> isLoggedIn();
  Future<Either<String, LoginResponse>> getUserData();
}
