import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<Failure, void>> book(BookGuideEntity entity);
  Future<Either<Failure, List<GuideEntity>>> getAllGuides();
  Future<Either<Failure,List<BookGuideEntity>>> getAllUserBookings(String userId);
  Future<Either<Failure,void>> deleteBooking(String bookingId);

}
