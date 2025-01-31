import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(String username, String password) async {
  try {
    final token = await authRemoteDataSource.loginUser(username, password);
    return Right(token);
  } catch (e) {
    return Left(ApiFailure(message: "Login failed: ${e.toString()}"));
  }
}
  

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user)async {
    try{
      await authRemoteDataSource.registerUser(user);
      return Right(null);
    }
    catch(e){
      return Left(ApiFailure(message: e.toString()));
    }

  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file)async {
    try{
      final imageName = await authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    }
    catch(e){
      return Left(ApiFailure(message: e.toString()));
    }
  }
}