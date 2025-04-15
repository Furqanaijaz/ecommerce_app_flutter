import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/mapper/products.dart';
import 'package:ecommerce_app/data/product/model/products_model.dart';
import 'package:ecommerce_app/data/product/source/product.dart';
import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/domain/product/repository/product.dart';
import 'package:ecommerce_app/service_locator.dart';

class ProductRepoImpl extends ProductRepository {
  @override
  Future<Either> getAllProducts() async {
    var returnData = await sl<ProductSource>().getAllProducts();
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var products =
            List.from(data['products'])
                .map(
                  (item) => ProductMapper.mapModelToEntity(
                    ProductModel.fromJson(item),
                  ),
                )
                .toList();
        return Right(products);
      },
    );
  }

  @override
  Future<Either> searchProducts(String query) async {
    var returnData = await sl<ProductSource>().searchProducts(query);
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var product =
            List.from(data['products'])
                .map(
                  (item) => ProductMapper.mapModelToEntity(
                    ProductModel.fromJson(item),
                  ),
                )
                .toList();
        return Right(product);
      },
    );
  }

  @override
  Future<Either> getProductsbycategory(String url) async {
    var returnData = await sl<ProductSource>().getProductsbycategory(url);
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var products =
            List.from(data['products'])
                .map(
                  (item) => ProductMapper.mapModelToEntity(
                    ProductModel.fromJson(item),
                  ),
                )
                .toList();
        return Right(products);
      },
    );
  }

  @override
  Future<Either> getSimilarProducts(ProductEntity product) async {
    var returnData = await sl<ProductSource>().getAllProducts();

    return returnData.fold((error) => Left(error), (data) {
      var products =
          List.from(data['products'])
              .map(
                (item) =>
                    ProductMapper.mapModelToEntity(ProductModel.fromJson(item)),
              )
              .where(
                (p) =>
                    p.id != product.id && // not the same product
                    (p.title.toLowerCase().contains(
                          product.title.toLowerCase(),
                        ) || // check title match
                        p.category == product.category || // category match
                        p.brand == product.brand || // brand match
                        p.tags.any(
                          (tag) => product.tags.contains(tag),
                        ) // tag match
                        ),
              )
              .toList();

      // If no products match, fallback to showing other similar products
      if (products.isEmpty) {
        products =
            List.from(data['products'])
                .map(
                  (item) => ProductMapper.mapModelToEntity(
                    ProductModel.fromJson(item),
                  ),
                )
                // .where(
                //   (p) =>
                //       p.id != product.id && // not the same product
                //       (p.category ==
                //               product.category || // category match fallback
                //           p.brand == product.brand), // brand match fallback
                // )
                .toList();
      }

      return Right(products);
    });

    // return returnData.fold((error) => Left(error), (data) {
    //   var products =
    //       List.from(data['products'])
    //           .map(
    //             (item) =>
    //                 ProductMapper.mapModelToEntity(ProductModel.fromJson(item)),
    //           )
    //           .where(
    //             (p) =>
    //                 p.id != product.id && // not the same product
    //                 (p.category == product.category ||
    //                     p.brand == product.brand ||
    //                     p.tags.any((tag) => product.tags.contains(tag))),
    //           )
    //           .toList();

    //   return Right(products);
    // });
  }
}
