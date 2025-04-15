// import 'package:ecommerce_app/presentation/home/widget/product_grid.dart';
// import 'package:ecommerce_app/presentation/search/bloc/search_product_cubit.dart';
// import 'package:ecommerce_app/presentation/search/bloc/search_product_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SearchPage extends StatelessWidget {
//   TextEditingController searchController = TextEditingController();
//   @override
//   SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Search"),
//         backgroundColor: const Color(0xfff505081),
//       ),
//       body: BlocProvider(
//         create: (context) => SearchProductCubit(),
//         child: BlocBuilder<SearchProductCubit, SearchProductState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     onChanged: (value) {
//                       searchController.text = value;
//                       context.read<SearchProductCubit>().searchProduct(value);
//                     },
//                     decoration: InputDecoration(
//                       hintText: "Search for products",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: BlocBuilder<SearchProductCubit, SearchProductState>(
//                     builder: (context, state) {
//                       if (state is SearchProductLoadingState) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (state is SearchProductLoadedState) {
//                         if (state.products.isEmpty) {
//                           return const Center(child: Text("No results found"));
//                         }

//                         return ListView.builder(
//                           itemCount: state.products.length,
//                           itemBuilder: (context, index) {
//                             final product = state.products[index];
//                             return ListTile(
//                               leading: Image.network(
//                                 product.thumbnail,
//                                 width: 50,
//                               ),
//                               title: Text(product.title),
//                               subtitle: Text("\$${product.price}"),
//                             );
//                           },
//                         );
//                       } else if (state is SearchProductErrorState) {
//                         return Center(child: Text(state.error));
//                       }
//                       return const Center(child: Text("Search for products"));
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommerce_app/core/config/appverctor.dart';
import 'package:ecommerce_app/presentation/product/page/product_detail.dart';
import 'package:ecommerce_app/presentation/search/bloc/search_product_cubit.dart';
import 'package:ecommerce_app/presentation/search/bloc/search_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 30, left: 5, right: 5),
        child: BlocProvider(
          create: (context) => SearchProductCubit(),

          child: BlocBuilder<SearchProductCubit, SearchProductState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      onChanged: (value) {
                        searchController.text = value;
                        context.read<SearchProductCubit>().searchProduct(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon:
                            searchController.text.isNotEmpty
                                ? IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    context
                                        .read<SearchProductCubit>()
                                        .searchProduct("");
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  ),
                                )
                                : null,
                        hintText: "Search for products",
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<SearchProductCubit, SearchProductState>(
                      builder: (context, state) {
                        if (state is SearchProductLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is SearchProductLoadedState) {
                          if (searchController.text.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSelfw8STLbWsZl6IbsQgJafAJcKttu3MmoA&s",
                                    width: 80,
                                    height: 80,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Search for products",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state.products.isEmpty) {
                            return Center(
                              child: Image.network(
                                "https://img.freepik.com/premium-vector/vector-illustration-about-concept-no-items-found-no-results-found_675567-6604.jpg",

                                width: 150,
                                height: 150,
                              ),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder:
                                (context, index) => SizedBox(height: 10),
                            itemCount: state.products.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => ProductDetailPage(
                                                    product:
                                                        state.products[index],
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 300,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  1,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    state
                                                        .products[index]
                                                        .thumbnail,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),

                                                // color: const Color.fromARGB(255, 64, 89, 231),
                                                color: const Color(0xfff8686AC),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),

                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.amber[300],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    2.0,
                                                  ),
                                                  child: Text(
                                                    state
                                                                    .products[index]
                                                                    .discountPercentage
                                                                    .toString()
                                                                    .length >
                                                                2 &&
                                                            state
                                                                    .products[index]
                                                                    .discountPercentage
                                                                    .toString()
                                                                    .substring(
                                                                      0,
                                                                      2,
                                                                    ) !=
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
                                          state.products[index].title
                                                      .toString()
                                                      .length >
                                                  25
                                              ? "${state.products[index].title.toString().substring(0, 25)}..."
                                              : state.products[index].title
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                bottomRight: Radius.circular(
                                                  20,
                                                ),
                                              ),
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
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
                          );
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSelfw8STLbWsZl6IbsQgJafAJcKttu3MmoA&s",
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Search for products",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
