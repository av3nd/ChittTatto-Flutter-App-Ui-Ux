import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:chitto_tatto/features/home/presentation/view/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/global_variables.dart';
import '../widget/below_app_bar.dart';

class AccountScreen extends ConsumerStatefulWidget {
  // const AccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    // Read the user object from the authViewModelProvider
    var userState = ref.read(authViewModelProvider);

    // Print the users list
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/chitotato.png',
                  width: 120,
                  height: 65,
                  color: Colors.black,
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: const Row(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(right: 15),
              //         child: Icon(Icons.notifications_outlined),
              //       ),
              //       Icon(Icons.search),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BelowAppBar(
                user: userState
                    .users.last), // Pass the user object to BelowAppBar
            const SizedBox(height: 10),
            const TopButtons(),
            // Text(
            //     'Current User: ${userState.currentUser?.userName ?? "No user logged in"}')
            // // EditUserView(
            //   user: userState.users.last,
            // ),
            // SizedBox(height: 20),
            // Orders(),
          ],
        ),
      ),
    );
  }
}
