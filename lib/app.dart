import 'package:flutter/material.dart';
import 'package:guide_go/view/landing_pg_view.dart';
import 'package:guide_go/view/dashboard_view.dart';


class GuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPageView(),
    );
  }
}