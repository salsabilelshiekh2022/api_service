import 'package:elmohtaref/core/database/cache/cache_helper.dart';

import '../../features/auth/data/models/user_model.dart';
import '../database/cache/cache_services.dart';

class UserCacheService {
  UserModel? get currentUser => CacheServices().getDataFromCache<UserModel>(
        boxName: CacheBoxes.userModelBox,
        key: "user",
      );
}
