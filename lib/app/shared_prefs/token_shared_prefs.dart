import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

Future<Either<Failure, void>> saveUserData(Map<String, dynamic> userData) async {
  try {
    await _sharedPreferences.setString('userId', userData['userId']);
    if (userData.containsKey('refreshToken')) {
      await _sharedPreferences.setString('refreshToken', userData['refreshToken']);
    }
    return Right(null);
  } catch (e) {
    return Left(SharedPrefsFailure(message: e.toString()));
  }
}

  Future<Either<Failure, Map<String, String>>> getUserData() async {
    try {
      final data = {
        'userId': _sharedPreferences.getString('userId') ?? '',
      };
      return Right(data);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
