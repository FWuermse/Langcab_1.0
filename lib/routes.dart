import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'src/home/home_component.dart.template.dart' as home_template;
import 'src/add/word_add_component.dart.template.dart' as hero_template;
import 'HeroList/hero_list_component.template.dart' as hero_list_template;
import 'Home/home_component.template.dart' as home_template;

export 'route_paths.dart';

class Routes {
  static final dashboard = RouteDefinition(
    routePath: RoutePaths.home,
    component: home_template.HomeComponentNgFactory,
  );

  static final words = RouteDefinition(
    routePath: RoutePaths.words,
    component: hero_template.HeroComponentNgFactory,
  );

  static final add = RouteDefinition(
    routePath: RoutePaths.add,
    component: hero_list_template.HeroListComponentNgFactory,
  );

  static final edit = RouteDefinition(
    routePath: RoutePaths.edit,
    component: home_template.HomeComponentNgFactory,
  );

  static final language = RouteDefinition(
    routePath: RoutePaths.language,
    component: home_template.HomeComponentNgFactory,
  );

  static final train = RouteDefinition(
    routePath: RoutePaths.train,
    component: home_template.HomeComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    dashboard,
    add,
    edit,
    words,
    language,
    train,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl(),
    ),
  ];
}
