import 'package:elmohtaref/core/components/widgets/custom_app_bar.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/should_login_widget.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/utils/user_cache_service.dart';
import '../../data/repos/notifications_repo.dart';
import '../cubit/notifications_cubit.dart';
import 'widgets/notifications_list.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(getIt<NotificationRepository>()),
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(title: context.notification, isBack: true),
            24.verticalSpace,
            UserCacheService().currentUser == null
                ? const ShouldLoginWidget()
                : const Expanded(child: NotificationsList()),
          ],
        ),
      ),
    );
  }
}
