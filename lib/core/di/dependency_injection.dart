import 'package:dio/dio.dart';
import 'package:elmohtaref/features/auth/data/repos/auth_repo.dart';
import 'package:elmohtaref/features/book_service/data/repos/book_service_repo.dart';
import 'package:elmohtaref/features/book_service/data/repos/book_service_repo_impl.dart';
import 'package:elmohtaref/features/home/home/data/repos/home_repo.dart';
import 'package:elmohtaref/features/home/home/data/repos/home_repo_impl.dart';
import 'package:elmohtaref/features/notification/data/repos/notifications_repo.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo_impl.dart';
import 'package:elmohtaref/features/service_details/data/repos/service_details_repo.dart';
import 'package:elmohtaref/features/support/data/repos/tech_support_repo.dart';
import 'package:elmohtaref/features/visits/data/repos/visits_repo.dart';
import 'package:elmohtaref/features/visits/data/repos/visits_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/notification/data/repos/notifications_repo_impl.dart';
import '../../features/service_details/data/repos/service_details_repo_impl.dart';
import '../../features/support/data/repos/tech_support_repo_impl.dart';
import '../database/cache/cache_services.dart';
import '../database/network/api_consumer.dart';
import '../database/network/dio_consumer.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CacheServices>(
    () => CacheServices(),
  );
  getIt.registerSingleton<ApiConsumer>(DioConsumer(
    dio: Dio()
      ..interceptors.add(
        RequestsInspectorInterceptor(),
      ),
    cacheServices: getIt<CacheServices>(),
  ));
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<TechSupportRepo>(
    () => TechSupportRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<ServiceDetailsRepo>(
    () => ServiceDetailsRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<BookServiceRepo>(
    () => BookServiceRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<VisitsRepo>(
    () => VisitsRepoImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<ReportsRepo>(
    () => ReportsRepoImpl(
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );
}
