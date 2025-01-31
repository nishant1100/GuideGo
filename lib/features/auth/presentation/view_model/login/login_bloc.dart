
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/home/presentation/view/home_view.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUsecase _loginUseCase;

  LoginBloc(
      {required RegisterBloc registerBloc,
      required HomeCubit homeCubit,
      required LoginUsecase loginUseCase})
      : _registerBloc = registerBloc,
        _loginUseCase = loginUseCase,
        _homeCubit = homeCubit,
        super(LoginState.initial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      print(event.username);
      print(event.password);
      final result = await _loginUseCase(
        LoginParams(
          email: event.username,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: failure.message ?? "Login failed",
            color: Colors.red,
          );
        },
        (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const HomeView(),
              ),
            );
          } 
      
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) =>
                BlocProvider.value(value: _homeCubit, child: event.destination),
          ));
    });
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _registerBloc,
              child: event.destination,
            ),
          ));
    });
  }
}
