import 'package:guide_go/features/booking/data/model/booking_api_model.dart';
import 'package:guide_go/features/booking/data/model/guide_api_model.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';

abstract interface class IBookingDataSource {
  // Future<String> loginUser(String username, String password);

  Future<void> bookGuide(BookGuideEntity entity);
  Future<List<GuideEntity>> getAllGuides();

  // Future<BookingEntity> getCurrentUser();

  // Future<String> uploadProfilePicture(File file);
}
