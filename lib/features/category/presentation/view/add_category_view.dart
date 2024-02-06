import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/presentation/widget/load_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/category_view_model.dart';

class AddCategoryView extends ConsumerStatefulWidget {
  const AddCategoryView({super.key});

  @override
  ConsumerState<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends ConsumerState<AddCategoryView> {
  final _key = GlobalKey<FormState>();

  final gap = const SizedBox(height: 8);
  final batchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var categoryState = ref.watch(categoryViewModelProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add Batch',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            TextFormField(
              controller: batchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Batch Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter batch';
                }
                return null;
              },
            ),
            gap,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    var category = CategoryEntity(
                      categoryName: batchController.text.trim(),
                    );

                    ref
                        .read(categoryViewModelProvider.notifier)
                        .addCategory(category);

                    // if (authState.error != null) {
                    //   showSnackBar(
                    //     message: authState.error.toString(),
                    //     context: context,
                    //     color: Colors.red,
                    //   );
                    // } else {
                    //   showSnackBar(
                    //     message: 'Registered successfully',
                    //     context: context,
                    //   );
                    // }
                  }
                },
                child: const Text('Add Category'),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (categoryState.isLoading) ...{
              const Center(child: CircularProgressIndicator()),
            } else if (categoryState.error != null) ...{
              Text(categoryState.error.toString()),
            } else if (categoryState.categories.isEmpty) ...{
              const Center(child: Text('No Categories')),
            } else ...{
              Expanded(
                child: LoadCategory(
                  lstCategories: categoryState.categories,
                  ref: ref,
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
