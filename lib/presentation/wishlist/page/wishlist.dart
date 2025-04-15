import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, List<ProductEntity>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(child: Text("No items in wishlist"));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(state[index].thumbnail),
              title: Text(state[index].title),
              subtitle: Text("\$${state[index].price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<WishlistCubit>().removeFromWishList(
                    state[index],
                  );
                },
              ),
            );
          },
          itemCount: state.length,
        );
      },
    );
  }
}
