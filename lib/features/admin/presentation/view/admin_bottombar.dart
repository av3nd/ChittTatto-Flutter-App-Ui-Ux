import 'package:chitto_tatto/config/constants/global_variables.dart';
import 'package:chitto_tatto/core/common/widgets/my_snackbar.dart';
import 'package:chitto_tatto/features/admin/presentation/view/all_user_screen.dart';
import 'package:chitto_tatto/features/admin/presentation/view/post_screen.dart';
import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:chitto_tatto/features/food/presentation/viewmodel/food_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/admin_viewmodel.dart';
import 'orders_screen.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  // var userState = ref.read(authViewModelProvider);

  List<Widget> pages = [
    const PostsScreen(),
    const AllUserScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Image.asset(
              //     'assets/images/amazon_in.png',
              //     width: 120,
              //     height: 45,
              //     color: Colors.black,
              //   ),
              // ),
              Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(foodViewModelProvider.notifier).fetchAllFoods();
              ref.read(authViewModelProvider.notifier).getAllUsers();
              ref.read(authViewModelProvider.notifier).getAllOrders(context);

              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          //analytics
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.supervised_user_circle),
            ),
            label: '',
          ),
          // orders
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: '',
          ),
          // cart
        ],
      ),
    );
  }
}
