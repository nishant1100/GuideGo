import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class ApiFailure extends Failure {
  final int? statusCode;
  const ApiFailure({
    this.statusCode,
    required super.message,
  });
}
  class SharedPrefsFailure extends Failure{
    SharedPrefsFailure({required super.message});
  }