import 'dart:io';

import 'package:guide_go/features/auth/data/model/auth_api_model.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(BookingEntity user);


  Future<String> uploadProfilePicture(File file);
   Future<AuthApiModel> updateProfile(BookingEntity user);
    Future<AuthApiModel> getUserData(String userId);
}
