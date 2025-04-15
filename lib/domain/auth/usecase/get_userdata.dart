import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/usecase/usecase.dart';
import 'package:ecommerce_app/data/auth/model/login_response.dart';
import 'package:ecommerce_app/domain/auth/repository/auth.dart';
import 'package:ecommerce_app/service_locator.dart';

class GetUserdataUseCase implements UseCase<Either, LoginResponse> {
  @override
  Future<Either> call({LoginResponse? params}) async {
    return await sl<AuthRepository>().getUserData();
  }
}
