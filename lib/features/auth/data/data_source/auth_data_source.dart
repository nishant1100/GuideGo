import 'dart:io';

import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(BookingEntity user);

  Future<BookingEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
