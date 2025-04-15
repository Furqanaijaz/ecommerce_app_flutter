import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
import 'package:ecommerce_app/presentation/addtocart/page/add_to_cart.dart';
import 'package:ecommerce_app/presentation/product/bloc/product_by_category_cubit.dart';
import 'package:ecommerce_app/presentation/product/bloc/product_by_category_state.dart';
import 'package:ecommerce_app/presentation/product/page/product_detail.dart';
import 'package:ecommerce_app/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategoryPage extends StatelessWidget {
  final String url;
  const ProductByCategoryPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                int itemCount = context.read<CartCubit>().totalItemsCount;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartPage()),
                    );
                  },
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      if (itemCount > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$itemCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create:
            (context) => ProductByCategoryCubit()..getProductByCategory(url),
        child: BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(
          builder: (context, state) {
            if (state is ProductByCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductByCategoryLoaded) {
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
                                      final product =
                                          products; // ✅ Use outer state
                                      final isFavorite = wishlist.contains(
                                        product,
                                      );

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
                                fontSize: 8,
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
                                    context.read<CartCubit>().addToCart(
                                      products,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: const Color.fromARGB(
                                      255,
                                      235,
                                      233,
                                      233,
                                    ),
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
            return const Center(child: Text("No products found"));
          },
        ),
      ),
    );
  }
}
