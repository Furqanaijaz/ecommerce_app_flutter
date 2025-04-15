// import 'package:ecommerce_app/domain/product/entity/product.dart';
// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   final ProductEntity products;
//   const ProductCard({super.key, required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//                           children: [
//                             Container(
//                               height: 150,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     state.products[index].thumbnail,
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),

//                                 // color: const Color.fromARGB(255, 64, 89, 231),
//                                 color: const Color(0xfff8686AC),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             Positioned(
//                               top: 1,
//                               right: 1,
//                               child: BlocBuilder<
//                                 WishlistCubit,
//                                 List<ProductEntity>
//                               >(
//                                 builder: (context, wishlist) {
//                                   final product = products; // ✅ Use outer state
//                                   final isFavorite = wishlist.contains(product);

//                                   return IconButton(
//                                     icon: Icon(
//                                       isFavorite
//                                           ? Icons.favorite
//                                           : Icons.favorite_border_outlined,
//                                       color:
//                                           isFavorite
//                                               ? Colors.red
//                                               : Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       if (isFavorite) {
//                                         context
//                                             .read<WishlistCubit>()
//                                             .removeFromWishList(product);
//                                       } else {
//                                         context
//                                             .read<WishlistCubit>()
//                                             .addToWishList(product);
//                                       }
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               top: 10,
//                               left: 10,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.amber[300],
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Text(
//                                     state.products[index].discountPercentage
//                                                     .toString()
//                                                     .length >
//                                                 2 &&
//                                             state
//                                                     .products[index]
//                                                     .discountPercentage
//                                                     .toString()
//                                                     .substring(0, 2) !=
//                                                 "0"
//                                         ? "${state.products[index].discountPercentage.toString().substring(0, 2)}%"
//                                         : "${state.products[index].discountPercentage.toString()}%",
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//   }
// }
