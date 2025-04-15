import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/usecase/usecase.dart';
import 'package:ecommerce_app/data/auth/model/auth.dart';
import 'package:ecommerce_app/domain/auth/repository/auth.dart';
import 'package:ecommerce_app/service_locator.dart';

class LoginUsecase implements UseCase<Either, LoginRequest> {
  @override
  Future<Either> call({LoginRequest? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
