import 'package:campus_square_app/external/login_data_cache//interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginDataCacheProvider = Provider<LoginDataCache>(
    (ref) {
      return LoginDataCache();
    }
);