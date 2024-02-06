import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/viewmodel/auth_view_model.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Call the function to fetch all orders
    ref.read(authViewModelProvider.notifier).getAllOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the AuthState
    return Consumer(
      builder: (context, watch, child) {
        final authState = ref.watch(authViewModelProvider);
        if (authState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Build your orders list using the authState.orders
          // You can use ListView.builder or any other widget here to display the orders
          return ListView.builder(
            itemCount: authState.orders.length + 1, // Add 1 for the heading
            itemBuilder: (context, index) {
              // Check if it's the first item (heading)
              if (index == 0) {
                return Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'All Orders',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                // Subtract 1 from index to adjust for the heading
                final order = authState.orders[index - 1];
                // Build your order item UI here using the order data
                return Card(
                  // Wrap ListTile with Card widget
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0, // Set the border radius here
                    ),
                  ),
                  elevation: 4, // Add elevation for a shadow effect
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ), // Optional margin for spacing
                  child: ListTile(
                    title: Text('Order ${index}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Price: Rs ${order.totalPrice.toString()}'),
                        Text('Address: ${order.address}'),
                        Text('Foods: ${getFoodsSummary(order.foods)}'),
                      ],
                    ),
                    // Add any other UI elements you want to show for each order
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Call the function to mark the food as delivered
                        // Pass the order ID or any other unique identifier to the function
                        ref
                            .read(authViewModelProvider.notifier)
                            .deleteOrder(context, order.orderId.toString());
                      },
                      // Customize the button color and shape
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Change the color here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.0, // Set the border radius here
                          ),
                        ),
                      ),
                      child: Text(
                        'Food Delivered',
                        style: TextStyle(
                          color: Colors.white, // Change the text color here
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  // ...

  String getFoodsSummary(List<Map<String, dynamic>> foods) {
    String summary = '';
    for (var food in foods) {
      final foodName = food['name'];
      final foodPrice = food['price'];
      summary += '$foodName (Rs $foodPrice), ';
    }
    // Remove the trailing comma and space
    if (summary.isNotEmpty) {
      summary = summary.substring(0, summary.length - 2);
    }
    return summary;
  }
}
