import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/guarantee_sections.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_banners.dart';
import 'widgets/services_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    HomeAppBar(),
                    110.verticalSpace,
                  ],
                ),
                HomeBanners(),
              ],
            ),
          ),
          8.verticalSpace,
          ServicesSection(),
          8.verticalSpace,
          GuaranteeSections(),
        ],
      ),
    );
  }
}
