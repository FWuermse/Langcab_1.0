import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'src/home/home_component.template.dart' as home_template;
import 'src/words/words_component.template.dart' as words_template;
import 'src/add/word_add_component.template.dart' as add_template;
import 'src/edit/word_detail_component.template.dart' as edit_template;
import 'src/language/language_component.template.dart' as language_template;
import 'src/study/study_component.template.dart' as study_template;
import 'src/termsandprivacy/privacy_component.template.dart' as privacy_template;
import 'src/termsandprivacy/terms_component.template.dart' as terms_template;


export 'route_paths.dart';

class Routes {
  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: home_template.HomeComponentNgFactory,
  );

  static final words = RouteDefinition(
    routePath: RoutePaths.words,
    component: words_template.WordsComponentNgFactory,
  );

  static final add = RouteDefinition(
    routePath: RoutePaths.add,
    component: add_template.WordAddComponentNgFactory,
  );

  static final edit = RouteDefinition(
    routePath: RoutePaths.edit,
    component: edit_template.WordDetailComponentNgFactory,
  );

  static final language = RouteDefinition(
    routePath: RoutePaths.language,
    component: language_template.LanguageComponentNgFactory,
  );

  static final train = RouteDefinition(
    routePath: RoutePaths.train,
    component: study_template.StudyComponentNgFactory,
  );

  static final privacy = RouteDefinition(
    routePath: RoutePaths.privacy,
    component: privacy_template.PrivacyComponentNgFactory,
  );

  static final terms = RouteDefinition(
    routePath: RoutePaths.terms,
    component: terms_template.TermsComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    add,
    edit,
    words,
    language,
    train,
    privacy,
    terms,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl(),
    ),
  ];
}
