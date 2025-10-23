// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repos/auth_repo.dart' as _i507;
import '../../features/auth/data/repos/auth_repo_impl.dart' as _i152;
import '../../features/book_service/data/repos/book_service_repo.dart' as _i460;
import '../../features/book_service/data/repos/book_service_repo_impl.dart'
    as _i859;
import '../../features/home/home/data/repos/home_repo.dart' as _i948;
import '../../features/home/home/data/repos/home_repo_impl.dart' as _i228;
import '../../features/notification/data/repos/notifications_repo.dart'
    as _i660;
import '../../features/notification/data/repos/notifications_repo_impl.dart'
    as _i826;
import '../../features/reports/data/repos/reports_repo.dart' as _i666;
import '../../features/reports/data/repos/reports_repo_impl.dart' as _i1069;
import '../../features/service_details/data/repos/service_details_repo.dart'
    as _i511;
import '../../features/service_details/data/repos/service_details_repo_impl.dart'
    as _i972;
import '../../features/support/data/repos/tech_support_repo.dart' as _i863;
import '../../features/support/data/repos/tech_support_repo_impl.dart' as _i249;
import '../../features/visits/data/repos/visits_repo.dart' as _i871;
import '../../features/visits/data/repos/visits_repo_impl.dart' as _i111;
import '../database/cache/cache_services.dart' as _i408;
import '../database/network/api_consumer.dart' as _i742;
import '../database/network/dio_consumer.dart' as _i1062;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i408.CacheServices>(() => _i408.CacheServices());
    gh.lazySingleton<_i742.ApiConsumer>(
        () => _i1062.DioConsumer(cacheServices: gh<_i408.CacheServices>()));
    gh.lazySingleton<_i660.NotificationRepository>(
        () => _i826.NotificationRepositoryImpl(gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i871.VisitsRepo>(
        () => _i111.VisitsRepoImpl(gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i863.TechSupportRepo>(
        () => _i249.TechSupportRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i948.HomeRepo>(
        () => _i228.HomeRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i511.ServiceDetailsRepo>(() =>
        _i972.ServiceDetailsRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i460.BookServiceRepo>(
        () => _i859.BookServiceRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i666.ReportsRepo>(
        () => _i1069.ReportsRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    gh.lazySingleton<_i507.AuthRepo>(
        () => _i152.AuthRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()));
    return this;
  }
}
