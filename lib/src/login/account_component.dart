import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/scorecard/scoreboard.dart';
import 'package:angular_components/scorecard/scorecard.dart';
import 'package:angular_router/angular_router.dart';


@Component(
  selector: 'my-account',
  templateUrl: 'account_component.html',
  styleUrls: const ['account_component.css'],
  directives: const [
    coreDirectives,
    routerDirectives,
    ScoreboardComponent,
    ScorecardComponent,
    MaterialButtonComponent,
    materialDirectives,
    MaterialIconComponent,
    ModalComponent,
    MaterialInputComponent
  ],
)

class AccountComponent {

  AccountComponent();
  bool showBasicDialog = false;
}