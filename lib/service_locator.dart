import 'package:ecommerce_app/core/network/dio_clint.dart';
import 'package:ecommerce_app/data/auth/repo/auth.dart';
import 'package:ecommerce_app/data/auth/source/auth.dart';
import 'package:ecommerce_app/data/category/repository/category_repo_impl.dart';
import 'package:ecommerce_app/data/category/source/category.dart';
import 'package:ecommerce_app/data/product/repo/product_repo_impl.dart';
import 'package:ecommerce_app/data/product/source/product.dart';
import 'package:ecommerce_app/domain/auth/repository/auth.dart';
import 'package:ecommerce_app/domain/auth/usecase/get_userdata.dart';
import 'package:ecommerce_app/domain/auth/usecase/isLogin.dart';
import 'package:ecommerce_app/domain/auth/usecase/login_usecase.dart';
import 'package:ecommerce_app/domain/category/repository/category.dart';
import 'package:ecommerce_app/domain/category/usecase/get_category.dart'
    show GetCategoryUseCase;
import 'package:ecommerce_app/domain/product/repository/product.dart';
import 'package:ecommerce_app/domain/product/usecase/get_all_products.dart';
import 'package:ecommerce_app/domain/product/usecase/get_product_by_category.dart';
import 'package:ecommerce_app/domain/product/usecase/get_simila_products.dart';
import 'package:ecommerce_app/domain/product/usecase/search_product_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerSingleton<DioClient>(DioClient());

  //service
  sl.registerSingleton<CategorySource>(CategorySourceImpl());
  sl.registerSingleton<ProductSource>(ProductSourceImpl());
  sl.registerSingleton<AuthSource>(AuthSourceImpl());

  //repository
  sl.registerSingleton<CategoryRepository>(CategoryRepoImpl());
  sl.registerSingleton<ProductRepository>(ProductRepoImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //usecase
  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());
  sl.registerSingleton<GetAllProductsUseCase>(GetAllProductsUseCase());
  sl.registerSingleton<SearchProductUsecase>(SearchProductUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<IsloginUseCase>(IsloginUseCase());
  sl.registerSingleton<GetUserdataUseCase>(GetUserdataUseCase());
  sl.registerSingleton<GetSimilaProductsUseCase>(GetSimilaProductsUseCase());

  sl.registerSingleton<GetProductByCategoryUseCase>(
    GetProductByCategoryUseCase(),
  );
}
