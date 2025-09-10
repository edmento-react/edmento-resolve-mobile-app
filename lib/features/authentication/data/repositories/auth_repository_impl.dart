// lib/features/authentication/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:edmentoresolve/features/authentication/data/models/role_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/data/network/network_info.dart';
import '../../domain/entities/auth_result_entity.dart'; // Keep this for the return type of the repository methods
import '../../domain/entities/user_entity.dart'; // Keep this for the return type of getCurrentUser
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
// NOTE: auth_result_model.dart and user_model.dart are not directly used in the repository IMPL
// methods' return types or parameters, so they can be removed here to clear unused_import warnings.
// The data source implementations (remote and local) will handle the models.

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, AuthResult>> login(
    String email,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        // TEMPORARY: Use toEntity method for proper conversion
        // remoteDataSource.login returns AuthResultModel (a subtype of AuthResult)
        final authResultModel = await remoteDataSource.login(email, password);

        debugPrint('authResultModel: $authResultModel');
        // localDataSource.cacheAuthResult expects AuthResult, and AuthResultModel fits
        await localDataSource.cacheAuthResult(authResultModel);
        // TEMPORARY: Use toEntity method instead of casting
        // Return Right(AuthResultModel) which is implicitly upcast to Right(AuthResult)
        // return Right(authResultModel as AuthResult);
        return Right(authResultModel.toEntity());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // TEMPORARY: Remove remote logout API call - handle logout only on frontend
      // await remoteDataSource.logout();

      // Just clear local cache for logout
      await localDataSource.clearCache();
      return const Right(null);
    } on Failure catch (failure) {
      // Even if there's an error, clear local cache for consistency
      await localDataSource.clearCache();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // TEMPORARY: Use toEntity method for proper conversion
      // localDataSource.getCachedUser should return User (the entity)
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        // TEMPORARY: Use toEntity method instead of direct return
        // return Right(cachedUser);
        return Right(cachedUser.toEntity());
      } else {
        return const Left(CacheFailure('No cached user found'));
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final sessionId = await localDataSource.getCachedSessionId();
      return Right(sessionId != null && sessionId.isNotEmpty);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, AuthResult>> refreshToken(String refreshToken) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getCachedSessionId();
        if (sessionId == null) {
          return const Left(CacheFailure('No session ID found'));
        }
        final authResultModel = await remoteDataSource.refreshToken(
          refreshToken,
          sessionId,
        );
        await localDataSource.cacheAuthResult(authResultModel);
        // TEMPORARY: Use toEntity method instead of casting
        // return Right(authResultModel as AuthResult);
        return Right(authResultModel.toEntity());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> sendForgotPasswordOtp(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final send = await remoteDataSource.sendForgotPasswordOtp(email);
        return Right(send);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String email, String otp) async {
    if (await networkInfo.isConnected) {
      try {
        final isVeirfied = await remoteDataSource.verifyOtp(email, otp);
        return Right(isVeirfied);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> newPassword(
    String email,
    String newPassword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final isVeirfied = await remoteDataSource.newPassword(
          email,
          newPassword,
        );
        return Right(isVeirfied);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, RoleModel>> selectRole(String roleId) async {
    if (await networkInfo.isConnected) {
      try {
        final isVeirfied = await remoteDataSource.selectRlole(roleId);
        return Right(isVeirfied);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
