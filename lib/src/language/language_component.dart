import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:langcab_ui/src/language/Language.dart';
import 'package:langcab_ui/src/language/language_service.dart';
import 'package:langcab_ui/src/words/word_service.dart';

@Component(
  selector: 'hero-add',
  templateUrl: 'language_component.html',
  styleUrls: const ['language_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives, materialDirectives, ScoreboardComponent, ScorecardComponent, NgFor],
)
class LanguageComponent implements OnInit {
  List<String> myLanguages;
  List<Language> languages = [];
  String selectedLanguage;

  final ScoreboardType selectable = ScoreboardType.selectable;

  final Location _location;
  final LanguageService _languageService;
  final WordService _wordService;
  LanguageComponent(this._location, this._languageService, this._wordService);

  void ngOnInit() {
    loadLanguages();
  }

  void setLanguage(String language) {
    _languageService.setLanguage(language);
    _location.back();
  }

  void goBack() => _location.back();

  loadLanguages() async {
    myLanguages = await _languageService.getMyLanguages();
    selectedLanguage = await _languageService.getLanguage();
    for (String l in myLanguages) {
      int wordsAmount = await _wordService.getWordsAmount('', l);
      Language language = new Language(wordsAmount, l);
      languages.add(language);
    }
  }
}

