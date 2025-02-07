import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/shared_prefs/token_shared_prefs.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});
  
  const LoginParams.initial():
  username='',
  password='';
  
  
  @override
  List<Object?> get props => [username ,password];
}


class LoginUsecase implements UsecaseWithParams<String,LoginParams>{
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUsecase(this.repository,this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
// IF api then store token in shared preferences
        return repository.loginUser(params.username, params.password);

 
    }  
}

    // return repository.loginUser(params.username, params.password).then(
    //   (value){
    //     return value.fold((failure)=>Left(failure),
    //      (token){
    //       tokenSharedPrefs.saveToken(token);
    //       tokenSharedPrefs.getToken().then((value){
    //         print(value);
    //       });
    //       return Right(token);
    //      }
    //      );
    //   }
    // ); 