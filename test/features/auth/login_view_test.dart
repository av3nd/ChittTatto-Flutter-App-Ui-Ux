import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/core/common/widgets/custom_button.dart';
import 'package:chitto_tatto/features/auth/domain/use_case/auth_usecase.dart';
import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../unit_test/auth_register_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;

  // We are doing these for dashboard

  late bool isLogin;

  setUpAll(() async {
    // Because these mocks are already created in the register_view_test.dart file
    mockAuthUsecase = MockAuthUseCase();

    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginUser('hello@gmail.com', 'hello123'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase, null)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRegister,
          routes: AppRoute.getAppRoutes(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'hello@gmail.com');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'hello123');

    await tester.tap(
      find.widgetWithText(CustomButton, "Sign in"),
    );

    await tester.pumpAndSettle();

    expect(find.text('Admin'), findsOneWidget);
  });
}
