import 'package:chitto_tatto/core/failure/failure.dart';
import 'package:chitto_tatto/core/network/local/hive_service.dart';
import 'package:chitto_tatto/features/auth/data/model/user_hive_model.dart';
import 'package:chitto_tatto/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(userHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveServices _hiveService;
  final UserHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      await _hiveService.addUser(_authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String username,
    String password,
  ) async {
    try {
      UserHiveModel? users = await _hiveService.login(username, password);
      if (users == null) {
        return Left(Failure(error: 'email or password is wrong'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
