import 'package:flutter/material.dart';
import 'package:guide_go/core/app_theme/app_theme.dart';
import 'package:guide_go/view/landing_pg_view.dart';

class GuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: LandingPageView(),
    );
  }
}