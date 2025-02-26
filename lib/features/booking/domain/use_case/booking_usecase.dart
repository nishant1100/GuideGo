import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class BookingParams extends Equatable {
  final String? id;
  final String? userId;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;
  final String guideId;

  const BookingParams(
      {this.id,
      this.userId,
      required this.pickupDate,
      required this.pickupTime,
      required this.noofPeople,
      required this.pickupType,
      required this.guideId,
      required this.pickupLocation});
  @override
  // TODO: implement props
  List<Object?> get props => throw [];
}

class BookingUsecase implements UsecaseWithParams<void, BookingParams> {
  final IBookingRepository repository;

  BookingUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(BookingParams params) async {
    try {
      await repository.book(BookGuideEntity(
          id: params.id,
          userId: params.userId,
          pickupDate: params.pickupDate,
          pickupTime: params.pickupTime,
          noofPeople: params.noofPeople,
          guideId: params.guideId,
          pickupType: params.pickupType,
          pickupLocation: params.pickupLocation));
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }


}
