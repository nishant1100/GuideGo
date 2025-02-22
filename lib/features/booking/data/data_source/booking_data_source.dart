import 'dart:io';

import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';

abstract interface class IBookingDataSource {
  // Future<String> loginUser(String username, String password);

  Future<void> bookGuide(BookGuideEntity entity);

  // Future<BookingEntity> getCurrentUser();

  // Future<String> uploadProfilePicture(File file);
}
