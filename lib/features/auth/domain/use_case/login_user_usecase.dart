import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/shared_prefs/token_shared_prefs.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object?> get props => [username, password];
}

class LoginUsecase implements UsecaseWithParams<Map<String, dynamic>, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUsecase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(LoginParams params) async {
    final result = await repository.loginUser(params.username, params.password);

    return result.fold(
      (failure) => Left(failure),
      (jsonString) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

          // Extract token & userId from API response
          final String token = jsonMap['token'] ?? '';
          final String userId = jsonMap['userId'] ?? '';

          // Store token and userId in SharedPreferences
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.saveUserData({
            'userId': userId,
            'refreshToken': token, // Storing token as refreshToken for now
          });

          return Right(jsonMap);
        } catch (e) {
          return Left(ApiFailure(message: 'Failed to parse login response: $e'));
        }
      },
    );
  }
}
