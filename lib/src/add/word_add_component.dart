import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:langcab_ui/src/language/language_service.dart';
import 'package:langcab_ui/src/words/word.dart';
import 'package:langcab_ui/src/words/word_service.dart';

@Component(
  selector: 'hero-add',
  templateUrl: 'word_add_component.html',
  styleUrls: const ['word_add_component.css'],
  directives: const [coreDirectives, formDirectives, materialInputDirectives, MaterialFabComponent, MaterialIconComponent],
)
class WordAddComponent implements OnInit {
  Word word;
  final WordService _wordService;
  final Location _location;
  final LanguageService _languageService;

  String label = "Translation";

  WordAddComponent(this._wordService, this._location, this._languageService);

  void ngOnInit() {
    word = new Word(0, '', '', '', '');
    setLanguage();
  }

  setLanguage() async {
    word.language = await _languageService.getLanguage();
    label = 'Translation ${word.language}';
  }

  addWord(Word newWord) async {
    word = newWord;
    if (word.wordChinese.length > 0 ||
        word.wordEnglish.length > 0 ||
        word.language.length > 0) {
      await _wordService.create(
          word.wordEnglish, word.wordPinyin, word.wordChinese, word.language);
      _languageService.setLanguage(word.language);
      goBack();
    }
  }

  void goBack() => _location.back();
}
