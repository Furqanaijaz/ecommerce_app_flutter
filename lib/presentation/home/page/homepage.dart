import 'package:ecommerce_app/data/auth/model/login_response.dart';
import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
import 'package:ecommerce_app/presentation/addtocart/page/add_to_cart.dart';
import 'package:ecommerce_app/presentation/auth/bloc/userdata_cubit.dart';
import 'package:ecommerce_app/presentation/auth/bloc/userdata_state.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_all_products_cubit.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_category_cubit.dart';
import 'package:ecommerce_app/presentation/home/widget/categories.dart';
import 'package:ecommerce_app/presentation/home/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  final LoginResponse? userData;
  const Homepage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit()..fetchUser(), // <-- add this
          ),
          BlocProvider(
            create: (context) => GetAllProductsCubit()..getAllProducts(),
          ),
          BlocProvider(
            create: (context) => GetCategoryCubit()..getCategories(),
          ),
        ],

        child: SafeArea(
          child: Stack(
            children: [
              // Background
              Container(
                width: double.infinity,
                height: double.infinity,
                // color: const Color.fromARGB(255, 64, 89, 231),
                color: Color(0xfff505081),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Good day for shopping",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoading) {
                                    return CircularProgressIndicator();
                                  } else if (state is UserLoaded) {
                                    return Row(
                                      children: [
                                        Text(
                                          state.user.firstName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          state.user.lastName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (state is UserError) {
                                    return Text("Error: ${state.message}");
                                  }
                                  return SizedBox.shrink(); // Default case
                                },
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                int itemCount =
                                    context.read<CartCubit>().totalItemsCount;

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CartPage(),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.shopping_bag_outlined,
                                          color: Colors.white,
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
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.search, color: Colors.grey),
                              hintText: "Search for products",
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Popular Categories",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Categories(),
                  ],
                ),
              ),

              // Foreground - white container with rounded top corners
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.54,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 246, 246),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Center(child: ProductGrid()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
