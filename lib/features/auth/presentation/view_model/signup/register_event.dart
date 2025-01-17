

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterStudent extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String phone;
  final String username;
  final String password;

  const RegisterStudent({
    required this.context,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.username,
    required this.password,
  });
}
