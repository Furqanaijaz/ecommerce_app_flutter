// import 'package:dartz/dartz.dart';
// import 'package:ecommerce_app/data/auth/model/auth.dart';
// import 'package:ecommerce_app/data/auth/source/auth.dart';
// import 'package:ecommerce_app/domain/auth/repository/auth.dart';
// import 'package:ecommerce_app/service_locator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthRepositoryImpl extends AuthRepository {
//   @override
//   Future<Either> login(LoginRequest loginRequest) async {
//     final returnData = await sl<AuthSource>().login(loginRequest);
//     return returnData.fold((error) => Left(error), (data) async {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();

//       final token = data['accessToken'];
//       if (token != null) {
//         await prefs.setString('token', token);
//       }

//       return Right(data);
//     });
//   }

//   @override
//   Future<bool> isLoggedIn() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     final token = sharedPreferences.getString('token');
//     if (token != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/auth/model/auth.dart';
import 'package:ecommerce_app/data/auth/source/auth.dart';
import 'package:ecommerce_app/domain/auth/repository/auth.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/data/auth/model/login_response.dart'; // Ensure this import is correct

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, LoginResponse>> login(LoginRequest loginRequest) async {
    final returnData = await sl<AuthSource>().login(loginRequest);

    return returnData.fold(
      (error) => Left(error), // Error case
      (data) async {
        // Assuming `data` is a `LoginResponse` object, not a map
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', data.id);
        await prefs.setString('username', data.username);
        await prefs.setString('email', data.email);
        await prefs.setString('first_name', data.firstName);
        await prefs.setString('last_name', data.lastName);
        await prefs.setString('gender', data.gender);
        await prefs.setString('image', data.image);
        await prefs.setString('access_token', data.accessToken);
        await prefs.setString('refresh_token', data.refreshToken);

        final token =
            data.accessToken; // Access the token from `LoginResponse` object
        if (token != null) {
          await prefs.setString('token', token);
        }

        return Right(data); // Returning the `LoginResponse` object as success
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    return token != null; // Returns true if token exists, else false
  }

  @override
  Future<Either<String, LoginResponse>> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString('access_token');
      if (accessToken == null) return Left("Access token not found");

      final user = LoginResponse(
        id: prefs.getInt('user_id') ?? 0,
        username: prefs.getString('username') ?? '',
        email: prefs.getString('email') ?? '',
        firstName: prefs.getString('first_name') ?? '',
        lastName: prefs.getString('last_name') ?? '',
        gender: prefs.getString('gender') ?? '',
        image: prefs.getString('image') ?? '',
        accessToken: accessToken,
        refreshToken: prefs.getString('refresh_token') ?? '',
      );

      return Right(user);
    } catch (e) {
      return Left("Failed to get user data: ${e.toString()}");
    }
  }
}
