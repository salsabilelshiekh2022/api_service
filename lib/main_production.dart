import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
      child: ElmohtarefApp(),
    ),
  ));
}
