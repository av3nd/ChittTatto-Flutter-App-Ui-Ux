import 'dart:io';

import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/global_variables.dart';
import '../../../food/presentation/viewmodel/food_view_model.dart';

class EditUserScreen extends ConsumerStatefulWidget {
  final UserEntity user;

  const EditUserScreen({required this.user, Key? key}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the existing food data
    _nameController = TextEditingController(text: widget.user.userName);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController =
        TextEditingController(text: widget.user.password.toString());
  }

  @override
  void dispose() {
    // Dispose the text controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  final _gap = const SizedBox(height: 8);

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text(
          'Edit Profile',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          // Add form fields here for editing the food details
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 12 / 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      ApiEndpoints.imageUrl + widget.user.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              _gap,
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
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey, // Add a background color if desired
                      image: _img != null
                          ? DecorationImage(
                              image: FileImage(_img!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image:
                                  AssetImage('assets/images/profileChange.png'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  )),
              _gap,
              TextFormField(
                key: const ValueKey('username'),
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              _gap,
              TextFormField(
                key: const ValueKey('email'),
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              _gap,
              TextFormField(
                key: const ValueKey('password'),
                controller: _passwordController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                }),
              ),
              // Add additional form fields as needed
              // Add a submit button to save the changes
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      var user = UserEntity(
                        userName: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        image: ref.read(authViewModelProvider).image,
                      );
                      ref
                          .read(authViewModelProvider.notifier)
                          .updateUser(context, widget.user.userId!, user);
                    }
                    // Perform the save action here
                  },
                  child: Text('Update User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
