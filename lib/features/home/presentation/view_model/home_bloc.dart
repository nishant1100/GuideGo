import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/features/home/presentation/view_model/home_event.dart';
import 'package:guide_go/features/home/presentation/view_model/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<NavigateBookingScreenEvent>((event, emit) {
      Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => event.destination,
          ));
    });
  }
}
