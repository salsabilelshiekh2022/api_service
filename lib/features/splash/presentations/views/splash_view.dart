import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../generated/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        mounted ? context.pushReplacementNamed(Routes.mainNavigation) : null;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.imagesSplash,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
