import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:chitto_tatto/features/auth/domain/use_case/auth_usecase.dart';
import 'package:chitto_tatto/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_register_unit_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<AuthUseCase>()],
)
void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late UserEntity userEntity;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUsecase),
        ),
      ],
    );

    userEntity = UserEntity(
        userName: 'avend', email: 'avend@gmail.com', password: 'avend123');
  });

  test('check for the initial state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('register test with valid username, email and password', () async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(userEntity);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('check for invalid username , email and password', () async {
    when(mockAuthUsecase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(userEntity);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(() {
    container.dispose();
  });
}
