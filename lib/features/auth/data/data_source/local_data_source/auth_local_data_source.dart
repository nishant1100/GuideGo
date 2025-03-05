import 'dart:io';

import 'package:guide_go/core/network/hive_service.dart';
import 'package:guide_go/features/auth/data/data_source/auth_data_source.dart';
import 'package:guide_go/features/auth/data/model/auth_api_model.dart';
import 'package:guide_go/features/auth/data/model/auth_user_model.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';

class BookingLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  BookingLocalDataSource(this._hiveService);

  @override
  Future<BookingEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const BookingEntity(
      userId: "1",
      full_Name: "",
      phone: "",
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      final user = await _hiveService.login(username, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(BookingEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<AuthApiModel> getUserData(String userId) {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<AuthApiModel> updateProfile(BookingEntity user) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
