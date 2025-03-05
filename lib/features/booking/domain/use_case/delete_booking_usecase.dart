import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class DeleteBookingParams extends Equatable {
  final String bookingId;

  const DeleteBookingParams({required this.bookingId});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteBookingUsecase
    implements UsecaseWithParams<void, DeleteBookingParams> {
  final IBookingRepository repository;

  DeleteBookingUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(DeleteBookingParams params) async{
    return await repository.deleteBooking(params.bookingId);
  }
}
