import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadCategory extends StatelessWidget {
  final WidgetRef ref;
  final List<CategoryEntity> lstCategories;
  const LoadCategory(
      {super.key, required this.lstCategories, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lstCategories.length,
      itemBuilder: ((context, index) => ListTile(
          title: Text(lstCategories[index].categoryName),
          subtitle: Text(lstCategories[index].categoryName),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                      'Are you sure you want to delete ${lstCategories[index].categoryName}?'),
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
                              .read(categoryViewModelProvider.notifier)
                              .deleteCategory(context, lstCategories[index]);
                        },
                        child: const Text('Yes')),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ))),
    );
  }
}
