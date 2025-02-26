import 'package:dartz/dartz.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:guide_go/features/booking/domain/repository/booking_repository.dart';

class GetAllGuidesUsecase implements UsecaseWithoutParams<List<GuideEntity>> {
  final IBookingRepository repository;

  GetAllGuidesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<GuideEntity>>> call() async {
    try {
      final response = await repository.getAllGuides();
      return response;
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
