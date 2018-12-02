import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';


@Component(
  selector: 'terms',
  templateUrl: 'terms_component.html',
  directives: const [
    coreDirectives,
    routerDirectives
  ],
)

class TermsComponent {

  TermsComponent();


}