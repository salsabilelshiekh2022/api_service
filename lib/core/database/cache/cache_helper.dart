import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/auth/data/models/user_model.dart';

abstract class CacheBoxes {
  static const String userModelBox = 'userModelBox';
  static const String globalBox = 'globalBox';
  static const String metaBox = 'metaBox';
}

abstract class CacheKeys {
  static const String token = 'token';
}

abstract class CacheHelper {
  static setUpCache() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter(), override: true);
    Hive.registerAdapter(MetaAdapter(), override: true);
    await Future.wait([
      Hive.openBox(
        CacheBoxes.userModelBox,
      ),
      Hive.openBox(
        CacheBoxes.metaBox,
      ),
    ]);
  }
}
