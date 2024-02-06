// Mocks generated by Mockito 5.4.2 from annotations
// in chitto_tatto/test/unit_test/auth_register_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i6;

import 'package:chitto_tatto/core/failure/failure.dart' as _i5;
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart'
    as _i7;
import 'package:chitto_tatto/features/auth/domain/use_case/auth_usecase.dart'
    as _i3;
import 'package:chitto_tatto/features/food/domain/entity/food_entity.dart'
    as _i8;
import 'package:chitto_tatto/features/food/domain/entity/order_entity.dart'
    as _i9;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i3.AuthUseCase {
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> uploadProfilePicture(
          _i6.File? file) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadProfilePicture,
          [file],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #uploadProfilePicture,
            [file],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #uploadProfilePicture,
            [file],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> registerUser(
          _i7.UserEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [user],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerUser,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerUser,
            [user],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> loginUser(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> checkUser(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkUser,
          [email],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #checkUser,
            [email],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #checkUser,
            [email],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.UserEntity>>> getAllUsers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllUsers,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i7.UserEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i7.UserEntity>>(
          this,
          Invocation.method(
            #getAllUsers,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<_i7.UserEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i7.UserEntity>>(
          this,
          Invocation.method(
            #getAllUsers,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.UserEntity>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUser,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUser,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> updateUser(
    String? id,
    _i7.UserEntity? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            id,
            user,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #updateUser,
            [
              id,
              user,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #updateUser,
            [
              id,
              user,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>> getMe(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMe,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
            _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #getMe,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #getMe,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.FoodEntity>>> addToCart(
          _i8.FoodEntity? food) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToCart,
          [food],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i8.FoodEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i8.FoodEntity>>(
          this,
          Invocation.method(
            #addToCart,
            [food],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<_i8.FoodEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i8.FoodEntity>>(
          this,
          Invocation.method(
            #addToCart,
            [food],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.FoodEntity>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>> removeFromCart(
          String? foodId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromCart,
          [foodId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
            _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #removeFromCart,
            [foodId],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #removeFromCart,
            [foodId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>> saveUserAddress(
          String? address) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUserAddress,
          [address],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
            _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #saveUserAddress,
            [address],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.UserEntity>(
          this,
          Invocation.method(
            #saveUserAddress,
            [address],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.UserEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.OrderEntity>>> orderMe() =>
      (super.noSuchMethod(
        Invocation.method(
          #orderMe,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.OrderEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.OrderEntity>>(
          this,
          Invocation.method(
            #orderMe,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.OrderEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.OrderEntity>>(
          this,
          Invocation.method(
            #orderMe,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.OrderEntity>>>);
}
