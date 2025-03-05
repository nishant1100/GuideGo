import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRemoteRepository({required this.bookingRemoteDataSource});

  @override
  Future<Either<Failure, void>> book(BookGuideEntity entity) async {
    try {
      await bookingRemoteDataSource.bookGuide(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GuideEntity>>> getAllGuides() async {
    try {
      final guides = await bookingRemoteDataSource.getAllGuides();
      return Right(guides);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<BookGuideEntity>>> getAllUserBookings(String userId) async{
    try {
      final bookings = await bookingRemoteDataSource.getUserBookings(userId);
      return Right(bookings);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteBooking(String bookingId)async {
    try{
      await bookingRemoteDataSource.deleteBooking(bookingId);
      return const Right(null);
    }
    catch(e){
      return Left(ApiFailure(message: e.toString()));
    }
  }

 
}
