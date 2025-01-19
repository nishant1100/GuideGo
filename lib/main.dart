
import 'package:flutter/material.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/app/app.dart';
import 'package:guide_go/core/network/hive_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService.init();

  // Initialize Dependencies

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    App(),
  );
}
