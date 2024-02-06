import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';

class ViewFood extends ConsumerStatefulWidget {
  final WidgetRef ref;

  final List<FoodEntity> foods;

  const ViewFood({Key? key, required this.ref, required this.foods})
      : super(key: key);

  @override
  _ViewFoodState createState() => _ViewFoodState();
}

class _ViewFoodState extends ConsumerState<ViewFood> {
  final int itemsPerPage = 5; // You can adjust this as per your requirement
  int currentPage = 0;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    totalPages = (widget.foods.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: totalPages,
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * itemsPerPage;
              int endIndex = (pageIndex + 1) * itemsPerPage;
              endIndex = endIndex.clamp(0, widget.foods.length);
              List<FoodEntity> currentItems =
                  widget.foods.sublist(startIndex, endIndex);

              return Row(
                children: currentItems
                    .map((food) => GestureDetector(
                          onTap: () {
                            _showFoodDetailsDialog(context, food);
                          },
                          child: SizedBox(
                            width:
                                180, // Adjust the width as per your requirement
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 8,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          ApiEndpoints.foodimageUrl +
                                              food.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          // Text(
                                          //   food.description,
                                          //   style: const TextStyle(
                                          //     fontSize: 14,
                                          //     color: Colors.black54,
                                          //   ),
                                          // ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Rs ${food.price.toString()}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
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
                ref
                    .read(authViewModelProvider.notifier)
                    .addToCart(context, food);
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
