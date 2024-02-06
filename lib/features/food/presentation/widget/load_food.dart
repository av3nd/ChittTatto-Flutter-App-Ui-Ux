import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../admin/presentation/widget/edit_view.dart';
import '../viewmodel/food_view_model.dart';

class LoadFood extends ConsumerWidget {
  // final WidgetRef ref;
  final List<FoodEntity> foods;
  const LoadFood({super.key, required this.foods});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var foodState =
        ref.watch(foodViewModelProvider); // Use foodViewModelProvider
    return SizedBox(
      height: 500,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // ref.read(foodViewModelProvider.notifier).fetchAllFoods();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      ApiEndpoints.foodimageUrl + foods[index].image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    // top: 10,
                    // left: 12,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          foods[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          foods[index].price.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                        'Are you sure you want to delete ${foods[index].name}?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            ref
                                                .read(foodViewModelProvider
                                                    .notifier)
                                                .deleteFood(
                                                  context,
                                                  foodState.foods![index],
                                                );
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
                                    builder: (context) =>
                                        EditFoodView(food: foods[index]),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
