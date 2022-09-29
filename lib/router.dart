import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:fullstack_e_commerce_app/features/admin/screens/add_product_screen.dart';
import 'package:fullstack_e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:fullstack_e_commerce_app/features/home/screens/category_deals_screen.dart';
import 'package:fullstack_e_commerce_app/features/home/screens/home_screen.dart';
import 'package:fullstack_e_commerce_app/features/search/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(category: category));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text("Screen not Exist")),
              ));
  }
}
