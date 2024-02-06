import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../category/domain/entity/category_entity.dart';
import '../../../category/presentation/viewmodel/category_view_model.dart';
import '../../../food/domain/entity/food_entity.dart';
import '../../../food/presentation/viewmodel/food_view_model.dart';

class EditFoodView extends ConsumerStatefulWidget {
  final FoodEntity food;

  const EditFoodView({required this.food, Key? key}) : super(key: key);

  @override
  _EditFoodViewState createState() => _EditFoodViewState();
}

class _EditFoodViewState extends ConsumerState<EditFoodView> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the existing food data
    _nameController = TextEditingController(text: widget.food.name);
    _descriptionController =
        TextEditingController(text: widget.food.description);
    _quantityController =
        TextEditingController(text: widget.food.quantity.toString());
    _priceController =
        TextEditingController(text: widget.food.price.toString());
  }

  @override
  void dispose() {
    // Dispose the text controllers
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  CategoryEntity? _dropDownValue;

  Future _browseImage(
      BuildContext context, WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(foodViewModelProvider.notifier).uploadFoodImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Edit Food'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          // Add form fields here for editing the food details
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.grey[300],
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                checkCameraPermission();
                                _browseImage(context, ref, ImageSource.camera);
                                Navigator.pop(context);
                                // Upload image it is not null
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(context, ref, ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey, // Add a background color if desired
                      image: _img != null
                          ? DecorationImage(
                              image: FileImage(_img!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/images/addfood.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  )),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),

              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              if (categoryState.isLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                )
              } else if (categoryState.error != null) ...{
                Center(
                  child: Text(categoryState.error!),
                )
              } else ...{
                DropdownButtonFormField(
                  items: categoryState.categories
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.categoryName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _dropDownValue = value;
                  },
                  value: _dropDownValue,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                  ),
                  validator: ((value) {
                    if (value == null) {
                      return 'Please select Category';
                    }
                    return null;
                  }),
                ),
              },
              // Add additional form fields as needed
              // Add a submit button to save the changes
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    var food = FoodEntity(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        quantity: int.parse(_quantityController.text),
                        image: ref.read(foodViewModelProvider).imageName,
                        category: _dropDownValue,
                        price: int.parse(_priceController.text));
                    ref
                        .read(foodViewModelProvider.notifier)
                        .updateFood(context, widget.food.foodId!, food);
                  }
                  // Perform the save action here
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
