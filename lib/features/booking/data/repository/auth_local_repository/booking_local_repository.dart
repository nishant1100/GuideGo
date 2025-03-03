import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';
import 'package:guide_go/features/booking/data/data_source/local_data_source/book_guide_local_data_source.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class BookingLocalRepository implements IBookingRepository {
  final BookGuideLocalDataSource bookguideLocalDatasource ;

  BookingLocalRepository(this.bookguideLocalDatasource);

  @override
  Future<Either<Failure, void>> book(BookGuideEntity entity) async{
    try {
      await bookguideLocalDatasource.bookGuide(entity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GuideEntity>>> getAllGuides() {
    // TODO: implement getAllGuides
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookGuideEntity>>> getAllUserBookings(String userId)async {
       try {
      final bookings = await bookguideLocalDatasource.getUserBookings(userId);
      return Right(bookings);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  

}
