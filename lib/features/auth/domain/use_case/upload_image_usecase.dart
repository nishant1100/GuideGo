import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';

class UploadImageParams extends Equatable {
  final File image;

  const UploadImageParams({
    required this.image,
    });

  //intial constructor
  const UploadImageParams.initial({ required this.image});

  @override
  List<Object?> get props => [image];
}
class UploadImageUsecase 
    implements UsecaseWithParams<String,UploadImageParams>{
  final IAuthRepository repository;

  UploadImageUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    print("usecase ${params.image}");
    return repository.uploadProfilePicture(params.image);
  }
}