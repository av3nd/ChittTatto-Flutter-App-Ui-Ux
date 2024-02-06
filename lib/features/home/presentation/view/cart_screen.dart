import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/global_variables.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../../core/common/widgets/my_snackbar.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final int itemsPerPage = 5; // You can adjust this as per your requirement
  final TextEditingController _addressController = TextEditingController();
  String referenceId = "";
  bool paymentSuccessful = false;
  @override
  void initState() {
    super.initState();
    // Perform any initialization you need for the cart screen
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authViewModelProvider);
    double totalPrice = 0;
    for (var food in authState.cart) {
      totalPrice += food.price;
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(authViewModelProvider.notifier)
                  .getAllCartForCurrentUser(authState.userId!);
              showSnackBar(message: 'Refreshing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: (authState.cart.length / itemsPerPage).ceil(),
              itemBuilder: (context, pageIndex) {
                int startIndex = pageIndex * itemsPerPage;
                int endIndex = (pageIndex + 1) * itemsPerPage;
                endIndex = endIndex.clamp(0, authState.cart.length);
                List<FoodEntity> currentItems =
                    authState.cart.sublist(startIndex, endIndex);

                return Column(
                  children: currentItems
                      .map((food) => GestureDetector(
                            onTap: () {
                              _showFoodDetailsDialog(context, food);
                            },
                            child: SizedBox(
                              height:
                                  150, // Adjust the height as per your requirement
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors
                                    .cyan[100], // Set the box color to orange
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                              fit: BoxFit.fitWidth,
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
                                    ]),
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Total Price: Rs ${totalPrice.toStringAsFixed(2)} ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                CustomTextField(
                  controller: _addressController,
                  hintText:
                      'Enter Your Full Address Before Ordering Your Foods',
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add logic to handle Pay Now
                      // For example, you can navigate to a payment screen
                      payWithKhaltiInApp();
                      if (paymentSuccessful) {
                        ref.read(authViewModelProvider.notifier).createOrder(
                              context: context,
                              cart: authState.cart,
                              totalPrice: totalPrice,
                              address: _addressController.text.trim(),
                            );
                      } else {
                        // Show a snackbar or any message to indicate that payment was not successful.
                        // showSnackBar(
                        //     message: "Payment with Khalti failed",
                        //     context: context);
                      }
                    },
                    icon: Image.asset(
                      'assets/images/khalti.png', // Replace with the path of your logo asset
                      width: 40,
                      height: 40,
                    ),
                    label: const Text(
                      "Pay with Khalti",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 209, 145, 220), // Set the button color to purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).createOrder(
                          context: context,
                          cart: authState.cart,
                          totalPrice: totalPrice,
                          address: _addressController.text.trim());
                      // Add logic to handle Cash on Delivery
                      // For example, you can show a confirmation dialog
                    },
                    child: Text("Cash on Delivery"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            SimpleDialogOption(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    paymentSuccessful = true;
                    referenceId = success.idx;
                  });

                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
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
            TextButton(
              onPressed: () {
                print(food.foodId);
                // Remove from cart logic goes here
                Navigator.pop(context);
                ref
                    .read(authViewModelProvider.notifier)
                    .removeFromCart(context, food.id!);
              },
              child: Text("Remove from Cart"),
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
