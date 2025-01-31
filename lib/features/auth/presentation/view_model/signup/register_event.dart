

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class UploadImageEvent extends RegisterEvent{
  final BuildContext context;
  final File img;

  const UploadImageEvent({
    required this.context,
    required this.img,
  });

}


class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String full_Name;
  //final String lName;
  final String phone;
  final String username;
  final String password;
  final String image;

  const RegisterUser({
    required this.context,
    required this.full_Name,
    required this.phone,
    required this.username,
    required this.password,
    required this.image,
  });
}


