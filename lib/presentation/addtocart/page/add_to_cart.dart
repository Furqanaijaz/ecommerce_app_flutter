// import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Your Cart")),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state.items.isEmpty) {
//             return Center(child: Text("No items in cart"));
//           }

//           return ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(height: 20),

//             itemCount: state.items.length,
//             itemBuilder: (context, index) {
//               final product = state.items[index];
//               return Container(
//                 child: Row(
//                   children: [
//                     Image.network(product.thumbnail, width: 50, height: 50),
//                     SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.title.length > 20
//                               ? product.title.substring(0, 20) + "..."
//                               : product.title,
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           "quantity : ${product.quantity.toStringAsFixed(0)}",
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     Text(
//                       "\$${(product.price * product.quantity).toStringAsFixed(2)}",
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.remove_circle),
//                       onPressed: () {
//                         context.read<CartCubit>().removeFromWishList(product);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.add_circle),
//                       onPressed: () {
//                         context.read<CartCubit>().addToCart(product);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(child: Text("No items in cart"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final product = state.items[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Image.network(
                              product.thumbnail,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title.length > 15
                                      ? product.title.substring(0, 15) + "..."
                                      : product.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "quantity : ${product.quantity.toStringAsFixed(0)}",
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "\$${(product.price * product.quantity).toStringAsFixed(2)}",
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                context.read<CartCubit>().removeFromWishList(
                                  product,
                                ); // <-- fix here
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {
                                context.read<CartCubit>().addToCart(product);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Total Price at Bottom
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${state.items.fold(0.0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
