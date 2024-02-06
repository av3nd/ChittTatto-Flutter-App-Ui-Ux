import 'dart:io';

import 'package:chitto_tatto/features/category/domain/entity/category_entity.dart';
import 'package:chitto_tatto/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/constants/global_variables.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../food/presentation/viewmodel/food_view_model.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityNameController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _gap = const SizedBox(height: 8);
  CategoryEntity? _dropDownValue;

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityNameController.dispose();
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
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

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Sell Food',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                                  _browseImage(
                                      context, ref, ImageSource.camera);
                                  Navigator.pop(context);
                                  // Upload image it is not null
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(
                                      context, ref, ImageSource.gallery);
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
                            : DecorationImage(
                                image: const AssetImage(
                                    'assets/images/addfood.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: productNameController, hintText: "Food Name"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),

                const SizedBox(
                  height: 10,
                ),
                CustomTextField(controller: priceController, hintText: "Price"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: quantityNameController, hintText: "Quantity"),
                const SizedBox(
                  height: 10,
                ),
                _gap,
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
                _gap,
                // SizedBox(
                //   width: double.infinity,
                //   child: DropdownButton(
                //     value: category,
                //     icon: const Icon(Icons.keyboard_arrow_down),
                //     items: productCategories.map((String item) {
                //       return DropdownMenuItem(
                //         value: item,
                //         child: Text(item),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         category = newValue!;
                //       });
                //     },
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      var food = FoodEntity(
                          name: productNameController.text,
                          description: descriptionController.text,
                          quantity: int.parse(quantityNameController.text),
                          image: ref.read(foodViewModelProvider).imageName,
                          category: _dropDownValue,
                          price: int.parse(priceController.text));
                      ref
                          .read(foodViewModelProvider.notifier)
                          .sellFood(context, food);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
