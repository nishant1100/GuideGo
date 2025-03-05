import 'package:dartz/dartz.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/core/network/connectivity_listener.dart';
import 'package:guide_go/core/network/hive_service.dart';
import 'package:guide_go/features/booking/data/model/booking_hive_model.dart';
import 'package:guide_go/features/booking/data/repository/auth_local_repository/booking_local_repository.dart';
import 'package:guide_go/features/booking/data/repository/booking_remote_repository/booking_remote_repository.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class BookingRepositoryProxy implements IBookingRepository {
  final BookingLocalRepository localRepository;
  final BookingRemoteRepository remoteRepository;
  final ConnectivityListener connectivityListener;
  // final HiveService hive = new HiveService();

  BookingRepositoryProxy(
      {required this.localRepository,
      required this.connectivityListener,
      required this.remoteRepository});
  @override
  Future<Either<Failure, void>> book(BookGuideEntity entity) {
    // TODO: implement book
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GuideEntity>>> getAllGuides() {
    // TODO: implement getAllGuides
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookGuideEntity>>> getAllUserBookings(
      String userId) async {
    if (await connectivityListener.isConnected) {
      try {
        // Fetch data from the remote repository
        final result = await remoteRepository.getAllUserBookings(userId);

        // If the remote fetch is successful, save it to Hive
        // result.fold(
        //   (failure) {
        //     // If there's an error, return it
        //     return Left(failure);
        //   },
        //   (bookings) async {
        //     // Convert entities to Hive models and store them locally
        //     final bookingHiveModels = BookingHiveModel.fromEntityList(bookings);
        //     await hive.saveBookingsToHive(bookingHiveModels);
        //   },
        // );

        return result;
      } catch (e) {
        // If fetching from remote fails, fallback to local data
        return await localRepository.getAllUserBookings(userId);
      }
    } else {
      // No internet, fetch data from the local repository
      return await localRepository.getAllUserBookings(userId);
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteBooking(String bookingId) async{
       if (await connectivityListener.isConnected) {
      try {
        // Fetch data from the remote repository
        final result = await remoteRepository.deleteBooking(bookingId);
        return result;
        // If the remote fetch is successful, save it to Hive
        // result.fold(
        //   (failure) {
        //     // If there's an error, return it
        //     return Left(failure);
        //   },
        //   (bookings) async {
        //     // Convert entities to Hive models and store them locally
        //     final bookingHiveModels = BookingHiveModel.fromEntityList(bookings);
        //     await hive.saveBookingsToHive(bookingHiveModels);
        //   },
        // );

      } catch (e) {
        // If fetching from remote fails, fallback to local data
        return localRepository.getAllUserBookings(bookingId);
      }
    } else {
      // No internet, fetch data from the local repository
      return await localRepository.deleteBooking(bookingId);
    }
  
  }
}
