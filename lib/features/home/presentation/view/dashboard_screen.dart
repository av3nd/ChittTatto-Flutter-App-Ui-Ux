import 'package:chitto_tatto/config/constants/global_variables.dart';
import 'package:chitto_tatto/features/home/presentation/widget/category_widget.dart';
import 'package:chitto_tatto/features/home/presentation/widget/view_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/presentation/viewmodel/category_view_model.dart';
import '../../../food/presentation/viewmodel/food_view_model.dart';
import '../widget/carousel_image.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchFoodButtonPressed() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref.read(foodViewModelProvider.notifier).searchFood(context, query);
    } else {
      // Handle the case when the search query is empty
      print('Empty search query');
      // You can show a snackbar or display an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryState = ref.watch(categoryViewModelProvider);
    var foodState = ref.watch(foodViewModelProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: searchFoodButtonPressed,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search Here',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: searchFoodButtonPressed,
              //   tooltip: 'Search',
              // ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: CategoryWidget(
              ref: ref,
              categoryList: categoryState.categories,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hot Deals',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const CarouselImage(),
          const SizedBox(height: 1),
          Container(
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'All Foods',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Expanded(
            child: ViewFood(
              ref: ref,
              foods: foodState.foods!,
            ),
          ),
        ],
      ),
    );
  }
}
