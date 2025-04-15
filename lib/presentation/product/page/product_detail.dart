import 'package:ecommerce_app/common/bottom_navigation/page/navigation.dart';
import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/presentation/product/bloc/get_similar_product_cubit.dart';
import 'package:ecommerce_app/presentation/product/bloc/get_similar_product_state.dart';
import 'package:ecommerce_app/presentation/product/widget/product_card.dart';
import 'package:ecommerce_app/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => GetSimilarProductCubit()..getSimilarProducts(product),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Stack(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xfff8686AC),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.thumbnail,
                          width: double.infinity,

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    BackButton(
                      color: Colors.white,
                      onPressed:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Navigations(),
                            ),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Prouct Details:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<WishlistCubit, List<ProductEntity>>(
                      builder: (context, state) {
                        final products = product;
                        final isFavorite = state.contains(products);
                        return IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context.read<WishlistCubit>().removeFromWishList(
                                product,
                              );
                            } else {
                              context.read<WishlistCubit>().addToWishList(
                                product,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 20),
                    Text("${product.title}"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text("${product.price}"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text("${product.category}"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Brand",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text("${product.brand}"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Rating",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text(product.rating.toString()),
                    SizedBox(width: 10),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < product.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Stock",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Text("${product.stock}"),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Discription",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  product.description,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                if (product.tags.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Text("Tags", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children:
                        product.tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Colors.grey[200],
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.black26),
                            ),
                          );
                        }).toList(),
                  ),
                ],

                Text(
                  "Similar Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<GetSimilarProductCubit, GetSimilarProductState>(
                  builder: (context, state) {
                    if (state is SimilarProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SimilarProductError) {
                      return Text("Error: ${state.error}");
                    } else if (state is SimilarProductLoaded) {
                      if (state.product.isEmpty) {
                        return const Text("No similar products found.");
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),

                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.product.length,
                        itemBuilder: (context, index) {
                          final similarProduct = state.product[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ProductDetailPage(
                                        product: similarProduct,
                                      ),
                                ),
                              );
                            },
                            child: ProductCard(product: similarProduct),
                          );
                          // return ListTile(
                          //   leading: Image.network(
                          //     similarProduct.thumbnail,
                          //     width: 50,
                          //     height: 50,
                          //     fit: BoxFit.cover,
                          //   ),
                          //   title: Text(similarProduct.title),
                          //   subtitle: Text("Price: \$${similarProduct.price}"),
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder:
                          //             (_) => ProductDetailPage(
                          //               product: similarProduct,
                          //             ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
