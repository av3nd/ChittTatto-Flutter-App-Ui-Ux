// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:chitto_tatto/features/food/presentation/widget/food_widget.dart';
import 'package:chitto_tatto/features/food/presentation/widget/load_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';
import '../../../food/presentation/viewmodel/food_view_model.dart';

class PostsScreen extends ConsumerStatefulWidget {
  final String? categoryName;

  const PostsScreen({
    super.key,
    this.categoryName,
  });

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AppRoute.addFoodScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    var categoryState = ref.watch(categoryViewModelProvider);
    var foodState = ref.watch(foodViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child:
                  FoodWidget(ref: ref, categoryList: categoryState.categories),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'All Foods',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LoadFood(
                  foods: foodState.foods!,
                  // ref: ref,
                ),
              ),
            )
            // },
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToAddProduct();
        },
        tooltip: 'Add a Food',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
