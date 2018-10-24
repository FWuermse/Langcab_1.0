import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/scorecard/scoreboard.dart';
import 'package:angular_components/scorecard/scorecard.dart';
import 'package:angular_router/angular_router.dart';


@Component(
  selector: 'my-home',
  templateUrl: 'home_component.html',
  styleUrls: const ['home_component.css'],
  directives: const [
    coreDirectives,
    routerDirectives,
    ScoreboardComponent,
    ScorecardComponent,
    MaterialButtonComponent,
    materialDirectives,
    MaterialIconComponent,
    MaterialInputComponent
  ],
)

class HomeComponent {

  HomeComponent();
}