
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/home/presentation/view/home_view.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
import 'package:guide_go/features/home/presentation/view_model/home_event.dart';
import 'package:guide_go/features/home/presentation/view_model/home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {



  HomeBloc()
      : 
        super(HomeState.initial()) {
        

    on<NavigateBookingScreenEvent>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => event.destination,
          ));
    });
  }
}
