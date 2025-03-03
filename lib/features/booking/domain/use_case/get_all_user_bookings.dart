import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class GetAllUserBookingsPrams extends Equatable{
  final String userId;

  const GetAllUserBookingsPrams({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];

}

class GetAllUserBookingsUsecase implements UsecaseWithParams<List<BookGuideEntity>,GetAllUserBookingsPrams> {
  final IBookingRepository repository;

  GetAllUserBookingsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<BookGuideEntity>>> call(GetAllUserBookingsPrams params) async {
    try {
      final response = await repository.getAllUserBookings(params.userId);
      return response;
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
