import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/global_variables.dart';

class UserCategoryFoodView extends ConsumerStatefulWidget {
  final String? categoryName;
  const UserCategoryFoodView(this.categoryName, {Key? key}) : super(key: key);

  @override
  _UserCategoryFoodViewState createState() => _UserCategoryFoodViewState();
}

class _UserCategoryFoodViewState extends ConsumerState<UserCategoryFoodView> {
  @override
  Widget build(BuildContext context) {
    var foodState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text(
          'Explore Category Food',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     ref
          //         .read(authViewModelProvider.notifier)
          //         .getAllCartForCurrentUser(authState.userId!);
          //     showSnackBar(message: 'Refreshing...', context: context);
          //   },
          //   icon: const Icon(
          //     Icons.refresh,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (foodState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (foodState.error != null) ...{
              Text(foodState.error!),
            } else if (foodState.foods!.isEmpty) ...{
              const Center(
                child: Text('No Foods'),
              ),
            } else ...{
              Expanded(
                child: ListView.builder(
                  itemCount: foodState.foods?.length ?? 0,
                  itemBuilder: (context, index) {
                    var food = foodState.foods![index];
                    return GestureDetector(
                      onTap: () {
                        _showFoodDetailsDialog(context, food);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            height: double.infinity,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                ApiEndpoints.foodimageUrl + food.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(food.name),
                          subtitle: Text(food.price.toString()),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     // Perform the edit action here
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //     builder: (context) => EditFoodView(
                          //     //         food: foodState.foods![index]),
                          //     //   ),
                          //     // );
                          //   },
                          //   icon: const Icon(Icons.remove_red_eye_outlined),
                          // ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  void _showFoodDetailsDialog(BuildContext context, FoodEntity food) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(food.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                ApiEndpoints.foodimageUrl + food.image!,
                fit: BoxFit.cover,
                width: 200,
                height: 120,
              ),
              const SizedBox(height: 10),
              Text(
                "Description:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(food.description),
              const SizedBox(height: 10),
              Text(
                "Price: Rs ${food.price.toString()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add to cart logic goes here
                Navigator.pop(context);
              },
              child: Text("Add to Cart"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
