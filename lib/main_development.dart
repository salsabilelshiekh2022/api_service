import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/utils/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'app/elmohtaref_app.dart';
import 'core/utils/service_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesInit.init();
  runApp(Phoenix(
    child: EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale(
        'ar',
      ),
      startLocale: const Locale(
        'ar',
      ),
      child: RequestsInspector(
        hideInspectorBanner: true,
        navigatorKey: AppKeys.navigatorKey,
        enabled: true,
        child: ElmohtarefApp(),
      ),
    ),
  ));
}
