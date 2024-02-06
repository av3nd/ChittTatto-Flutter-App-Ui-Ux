import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../admin/presentation/viewmodel/admin_viewmodel.dart';
import '../../../auth/presentation/viewmodel/auth_view_model.dart';
import 'account_button.dart';
import 'edit_user_screen.dart';

class TopButtons extends ConsumerStatefulWidget {
  const TopButtons({super.key});

  @override
  ConsumerState<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends ConsumerState<TopButtons> {
  @override
  Widget build(BuildContext context) {
    var authState = ref.read(authViewModelProvider);
    return Column(
      children: [
        Row(
          children: [
            // AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(
                text: 'Edit Profile',
                onTap: () {
                  // Null check
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserScreen(
                        user: authState.users.last, // Null check
                      ),
                    ),
                  );
                }),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () {
                ref.read(homeViewModelProvider.notifier).logout(context);
              },
            ),
            // AccountButton(text: 'Your Wish List', onTap: () {}),
          ],
        )
      ],
    );
  }
}
