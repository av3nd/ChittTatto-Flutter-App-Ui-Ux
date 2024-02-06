import 'package:chitto_tatto/features/admin/presentation/widget/edit_view.dart';
import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:chitto_tatto/features/food/presentation/viewmodel/food_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';

class CategoryFoodView extends ConsumerStatefulWidget {
  final String? categoryName;
  const CategoryFoodView(this.categoryName, {Key? key}) : super(key: key);

  @override
  _CategoryFoodViewState createState() => _CategoryFoodViewState();
}

class _CategoryFoodViewState extends ConsumerState<CategoryFoodView> {
  @override
  Widget build(BuildContext context) {
    var foodState = ref.watch(categoryViewModelProvider);

    return Scaffold(
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
                    print(
                      foodState.foods![index].toJson(),
                    );
                    return Card(
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
                                ApiEndpoints.foodimageUrl +
                                    foodState.foods![index].image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(foodState.foods![index].name),
                          subtitle:
                              Text(foodState.foods![index].price.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                          'Are you sure you want to delete ${foodState.foods![index].name}?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(foodViewModelProvider
                                                      .notifier)
                                                  .deleteFood(
                                                    context,
                                                    foodState.foods![index],
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes')),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Perform the edit action here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditFoodView(
                                          food: foodState.foods![index]),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          )),
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
}
