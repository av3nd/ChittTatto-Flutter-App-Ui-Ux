import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../widget/edit _user_view.dart';

class AllUserScreen extends ConsumerStatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends ConsumerState<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'All Users',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (userState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (userState.error != null) ...{
              Text(userState.error!),
            } else if (userState.users.isEmpty) ...{
              const Center(
                child: Text('No Foods'),
              ),
            } else ...{
              Expanded(
                child: ListView.builder(
                  itemCount: userState.users.length,
                  itemBuilder: (context, index) {
                    // Check if the image URL is null or empty, and provide a default image in such cases
                    final imageUrl = ApiEndpoints.imageUrl +
                        (userState.users[index].image ?? '');

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          height: double.infinity,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                            userState.users[index].userName ?? 'Unknown User'),
                        subtitle: Text(
                            userState.users[index].email?.toString() ??
                                'Unknown Email'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Are you sure you want to delete ${userState.users[index].userName ?? 'this user'}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(authViewModelProvider
                                                  .notifier)
                                              .deleteUser(
                                                context,
                                                userState.users[index].userId!,
                                              );
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUserView(
                                      user: userState.users[index],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
