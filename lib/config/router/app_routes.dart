import 'package:chitto_tatto/core/common/widgets/bottom_bar.dart';
import 'package:chitto_tatto/features/auth/presentation/view/auth_screen.dart';
import 'package:chitto_tatto/features/splash/presentation/view/splash_view.dart';

import '../../features/admin/presentation/view/add_product_screen.dart';
import '../../features/admin/presentation/view/admin_bottombar.dart';
import '../../features/category/presentation/view/category_food.dart';
import '../../features/home/presentation/view/category_food_view.dart';

class AppRoute {
  AppRoute._();
  static const String splashRoute = '/splash';
  static const String loginRegister = '/loginregisterRoute';
  static const String bottomBarRoute = '/bottomBarRoute';
  static const String adminBottomBarRoute = '/adminBottomBarRoute';
  static const String addFoodScreenRoute = '/addFoodScreenRoute';
  static const String categoryFoodsRoute = '/categoryFoodsRoute';
  static const String editFoodViewRoute = '/editFoodViewRoute';
  static const String userCategoryFoodsRoute = '/userCategoryFoodsRoute';
  static const String searchScreenRoute = '/searchScreenRoute';

  static getAppRoutes() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRegister: (context) => const AuthScreen(),
      bottomBarRoute: (context) => const BottomBar(),
      adminBottomBarRoute: (context) => const AdminScreen(),
      addFoodScreenRoute: (context) => const AddProductScreen(),
      categoryFoodsRoute: (context) => const CategoryFoodView(null),
      userCategoryFoodsRoute: (context) => const UserCategoryFoodView(null),
    };
  }
}
