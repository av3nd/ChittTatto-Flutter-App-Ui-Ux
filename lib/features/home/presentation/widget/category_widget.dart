import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryWidget extends StatelessWidget {
  final WidgetRef ref;
  final List<CategoryEntity> categoryList;
  const CategoryWidget(
      {super.key, required this.ref, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        // Put this otherwise it will take all the space
        shrinkWrap: true,
        itemCount: categoryList.length,
        // physics: const NeverScrollableScrollPhysics(),
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, childAspectRatio: 1.5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              ref
                  .read(categoryViewModelProvider.notifier)
                  .getAllUserFoodsByCategory(
                    context,
                    categoryList[index].categoryId!,
                  );
            },
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                width: 80,
                // height: 100,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    categoryList[index].categoryName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
