import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';


class GetUserParams extends Equatable {
  final String userId;

  GetUserParams({required this.userId});

  const GetUserParams.initial() : userId = '';

  @override
  List<Object?> get props => [userId];
}

class GetUserDataUsecase
    implements UsecaseWithParams<BookingEntity, GetUserParams> {
  final IAuthRepository authRepository;

  GetUserDataUsecase({required this.authRepository});

  @override
  Future<Either<Failure, BookingEntity>> call(GetUserParams params) async {
    return await authRepository.getUserdata(params.userId);
  }
}
