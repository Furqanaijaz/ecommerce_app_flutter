import 'package:ecommerce_app/common/bottom_navigation/bloc/bottom_navigation_cubit.dart';
import 'package:ecommerce_app/common/bottom_navigation/bloc/bottom_navigation_state.dart';
import 'package:ecommerce_app/data/auth/model/login_response.dart';
import 'package:ecommerce_app/presentation/home/page/homepage.dart';
import 'package:ecommerce_app/presentation/profile/page/profile.dart';
import 'package:ecommerce_app/presentation/search/page/search_page.dart';
import 'package:ecommerce_app/presentation/wishlist/page/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigations extends StatelessWidget {
  final LoginResponse? userData;
  const Navigations({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            switch (state.selectedIndex) {
              case 0:
                return Homepage(userData: userData);
              case 1:
                return Wishlist();
              case 2:
                return Profile(userData: userData);
              case 3:
                return SearchPage();
              default:
                return Homepage();
            }
          },
        ),
        bottomNavigationBar:
            BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: NavigationBar(
                    height: 60,
                    destinations: [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        label: "Home",
                        selectedIcon: Icon(
                          Icons.home_filled,
                          color: Color.fromARGB(255, 127, 103, 250),
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.favorite_border_outlined),
                        label: "Wishlist",
                        selectedIcon: Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 127, 103, 250),
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        label: "Profile",
                        selectedIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 127, 103, 250),
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.search_outlined),
                        label: "Search",
                        selectedIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 127, 103, 250),
                        ),
                      ),
                    ],
                    selectedIndex: state.selectedIndex,
                    onDestinationSelected:
                        (value) => context
                            .read<BottomNavigationCubit>()
                            .selectedIndex(value),
                  ),
                );
              },
            ),
      ),
    );
  }
}
