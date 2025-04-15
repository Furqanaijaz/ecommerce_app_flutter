import 'package:ecommerce_app/common/bottom_navigation/bloc/bottom_navigation_cubit.dart';
import 'package:ecommerce_app/presentation/addtocart/bloc/add_to_cart.dart';
import 'package:ecommerce_app/presentation/auth/bloc/userdata_cubit.dart';
import 'package:ecommerce_app/presentation/auth/login.dart';
import 'package:ecommerce_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommerce_app/presentation/splash/page/splash.dart';
import 'package:ecommerce_app/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationCubit>(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider<UserCubit>(create: (context) => UserCubit()..fetchUser()),

        BlocProvider<WishlistCubit>(create: (context) => WishlistCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:
            SplashScreen(), // ✅ Wishlist and BottomNavigation will now work here and everywhere below!
      ),
    );
  }
}
