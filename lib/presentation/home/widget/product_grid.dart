import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_all_products_cubit.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_all_products_state.dart';
import 'package:ecommerce_app/presentation/product/page/product_detail.dart';
import 'package:ecommerce_app/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
      builder: (context, state) {
        if (state is GetAllProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllProductsLoadedState) {
          return GridView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final products = state.products[index];

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductDetailPage(
                                    product: state.products[index],
                                  ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    state.products[index].thumbnail,
                                  ),
                                  fit: BoxFit.cover,
                                ),

                                // color: const Color.fromARGB(255, 64, 89, 231),
                                color: const Color(0xfff8686AC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              right: 1,
                              child: BlocBuilder<
                                WishlistCubit,
                                List<ProductEntity>
                              >(
                                builder: (context, wishlist) {
                                  final product = products; // ✅ Use outer state
                                  final isFavorite = wishlist.contains(product);

                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color:
                                          isFavorite
                                              ? Colors.red
                                              : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isFavorite) {
                                        context
                                            .read<WishlistCubit>()
                                            .removeFromWishList(product);
                                      } else {
                                        context
                                            .read<WishlistCubit>()
                                            .addToWishList(product);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    state.products[index].discountPercentage
                                                    .toString()
                                                    .length >
                                                2 &&
                                            state
                                                    .products[index]
                                                    .discountPercentage
                                                    .toString()
                                                    .substring(0, 2) !=
                                                "0"
                                        ? "${state.products[index].discountPercentage.toString().substring(0, 2)}%"
                                        : "${state.products[index].discountPercentage.toString()}%",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          state.products[index].title.toString().length > 25
                              ? "${state.products[index].title.toString().substring(0, 25)}..."
                              : state.products[index].title.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${state.products[index].price.toString().length > 3 ? state.products[index].price.toString().substring(0, 3) : state.products[index].price.toString()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.read<CartCubit>().addToCart(products);
                              },
                              icon: Icon(
                                Icons.add,
                                color: const Color.fromARGB(255, 235, 233, 233),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,

              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        }
        if (state is GetAllProductsErrorState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: Text("No products available"));
      },
    );
  }
}
