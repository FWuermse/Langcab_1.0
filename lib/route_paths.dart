import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final home = RoutePath(path: 'home');
  static final words = RoutePath(path: 'words');
  static final add = RoutePath(path: 'add');
  static final edit = RoutePath(path: '${words.path}/:$idParam');
  static final language = RoutePath(path: 'language');
  static final login = RoutePath(path: 'login');
  static final train = RoutePath(path: 'train');
}

int getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : int.tryParse(id);
}
