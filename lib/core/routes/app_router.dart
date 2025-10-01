import 'package:elmohtaref/core/routes/routes.dart';
import 'package:elmohtaref/features/book_service/data/repos/book_service_repo.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/book_service/presentaion/views/book_service_view.dart';
import 'package:elmohtaref/features/change_language/presentation/views/change_language_view.dart';
import 'package:elmohtaref/features/edit_profile/presentation/views/edit_profile.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:elmohtaref/features/home/home/presentation/views/home_view.dart';
import 'package:elmohtaref/features/main_navigatin/presentation/widgets/main_navigation.dart';
import 'package:elmohtaref/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:elmohtaref/features/splash/presentations/views/splash_view.dart';
import 'package:elmohtaref/features/support/data/repos/tech_support_repo.dart';
import 'package:elmohtaref/features/support/presentation/cubit/tech_support_cubit.dart';
import 'package:elmohtaref/features/support/presentation/views/add_ticket_view.dart';
import 'package:elmohtaref/features/support/presentation/views/tickets_list_view.dart';
import 'package:elmohtaref/features/visits/presentation/views/visits_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/otp_view.dart';
import '../../features/home/home/data/repos/home_repo.dart';
import '../../features/notification/presentation/views/notifications_view.dart';
import '../../features/reports/presentation/views/reports_view.dart';
import '../../features/service_details/data/repos/service_details_repo.dart';
import '../../features/service_details/presentation/views/service_details_view.dart';
import '../../features/setting/presentation/views/setting_view.dart';
import '../../features/support/presentation/views/report_problem_view.dart';
import '../di/dependency_injection.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      case Routes.homeView:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case Routes.mainNavigation:
        return MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        );
      case Routes.serviceDetailsView:
        final args = settings.arguments as Map<String, dynamic>?;
        final id = args!['id'] ?? -1;
        final String title = args['title'] ?? '';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ServiceDetailsCubit(
              getIt<ServiceDetailsRepo>(),
            ),
            child: ServiceDetailsView(
              id: id,
              title: title,
            ),
          ),
        );
      case Routes.bookServiceView:
        final args = settings.arguments as Map<String, dynamic>?;
        final title = args?['title'] ?? '';
        final int serviceId = args?['serviceId'] ?? -1;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BookServiceCubit(
              getIt<BookServiceRepo>(),
            ),
            child: BookServiceView(
              title: title,
              serciveId: serviceId,
            ),
          ),
        );
      case Routes.reportsView:
        return MaterialPageRoute(
          builder: (_) => const ReportsView(),
        );

      case Routes.editProfileView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(getIt<AuthRepo>()),
            child: const EditProfileView(),
          ),
        );
      case Routes.visitsView:
        return MaterialPageRoute(
          builder: (_) => const VisitsView(),
        );
      case Routes.settingsView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(
              getIt<HomeRepo>(),
            ),
            child: const SettingView(),
          ),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(
              getIt<AuthRepo>(),
            ),
            child: const LoginView(),
          ),
        );
      case Routes.otpView:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments as Map<String, dynamic>?;
          final phone = args?['phone'] ?? '';
          final String? name = args?['name'];
          final bool isFromLogin = args?['isFromLogin'] ?? true;
          final String? image = args?['image'];
          return BlocProvider(
            create: (context) => AuthCubit(
              getIt<AuthRepo>(),
            ),
            child: OtpView(
              phone: phone,
              isFromLogin: isFromLogin,
              name: name,
              image: image,
            ),
          );
        });

      case Routes.changeLanguageView:
        return MaterialPageRoute(
          builder: (_) => const ChangeLanguageView(),
        );
      case Routes.notificationView:
        return MaterialPageRoute(
          builder: (_) => const NotificationsView(),
        );
      case Routes.reportProblemView:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments as Map<String, dynamic>?;
          final id = args?['id'] ?? '';
          final cubit = args!['cubit'] as TechSupportCubit?;

          return BlocProvider.value(
            value: cubit!,
            child: ReportProblemView(
              id: id,
            ),
          );
        });

      case Routes.addTicketView:
        final args = settings.arguments as Map<String, dynamic>?;
        final cubit = args!['cubit'] as TechSupportCubit?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit!,
            child: const AddTicketView(),
          ),
        );
      case Routes.ticketsListView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TechSupportCubit(getIt<TechSupportRepo>()),
            child: const TicketsListView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
    }
  }
}
