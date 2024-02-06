import 'package:chitto_tatto/config/router/app_routes.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/use_case/auth_usecase.dart';
import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../unit_test/auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late UserEntity userEntity;

  // We are doing these for dashboard

  late bool isLogin;

  setUpAll(() async {
    // Because these mocks are already created in the register_view_test.dart file
    mockAuthUsecase = MockAuthUseCase();
    userEntity = UserEntity(
        userName: 'avend', email: 'avend@gmail.com', password: 'avend123');
    isLogin = true;
  });

  testWidgets('Register with username, email and password',
      (WidgetTester tester) async {
    when(mockAuthUsecase.registerUser(userEntity))
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
    await tester.enterText(find.byType(TextField).at(0), 'kiran');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'kiran@gmail.com');
    await tester.enterText(find.byType(TextField).at(2), 'kiran123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Sign Up'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Welcome To Chitto Tatto'), findsOneWidget);
  });
}
