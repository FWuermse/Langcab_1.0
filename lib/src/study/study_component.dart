import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:langcab_ui/src/language/language_service.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:langcab_ui/src/words/word.dart';
import 'word_study_service.dart';

@Component(
  selector: 'study',
  templateUrl: 'study_component.html',
  styleUrls: const ['study_component.css', 'study_component.css'],
  directives: const [
    coreDirectives,
    formDirectives,
    materialDirectives,
    ButtonDirective,
    displayNameRendererDirective,
    MaterialChipComponent,
    MaterialChipsComponent
  ],
)
class StudyComponent extends OnInit {
  Random random = new Random();
  List<Word> overdueWords;
  Word selectedWord = new Word(0,'','','', '');
  int amount = 0;
  int maxAmount = 0;
  int progressBar = 0;
  int tabIndex = 0;
  int difficulty;
  String language = '';
  String response = '';
  List<Word> wordSuggestions;
  List<Word> reversedWordSuggestions = new List();
  List<String> tabs = ['words', 'all words'];
  String colour = 'border-primary';
  String method = '(keyup.enter)="submit(response)';
  bool onCheck = false;
  bool reverted = false;
  bool tipNeeded = false;
  bool allLanguages = false;

  final StudyService _studyService;
  final LanguageService _languageService;
  StudyComponent(this._studyService, this._languageService);

  wordRevert(Word word) {
    return new Word(word.wordId, word.wordChinese, word.wordPinyin, word.wordEnglish, word.language);
  }

  revert() {
    if (reverted)
      reverted = false;
    else
      reverted = true;
    selectedWord = wordRevert(selectedWord);
    tipNeeded = false;
    wordSuggestions = [];
  }

  getOverdueWords() async {
    language = await _languageService.getLanguage();
    tabs = ['$language words', 'all words'];
    overdueWords = await _studyService.getOverdueWords(language);
    await overdueWords.shuffle();
    maxAmount = overdueWords.length;
    setFirstWord();
  }
  
  setFirstWord() {
    onCheck = false;
    colour = 'border-primary';
    method = '(keyup.enter)="submit(response)';
    response = '';
    tipNeeded = false;
    wordSuggestions = [];
    if (overdueWords.isNotEmpty) {
      if (!reverted)
        selectedWord = overdueWords.last;
      else
        selectedWord = wordRevert(overdueWords.last);
      amount = overdueWords.length;
    } else {
      amount = 0;
    }
    progressBar = _studyService.calculateProgress(maxAmount, amount);
  }

  setSuggestion() async {
    if (reverted)
      setSuggestionChinese();
    else {
      wordSuggestions = await _studyService.getWordSuggestions(selectedWord.language);
      tipNeeded = true;
      List<Word> toRemove = [];
      wordSuggestions.forEach( (Word w) {
        if(w.wordEnglish == selectedWord.wordEnglish)
          toRemove.add(w);
      });
      wordSuggestions.removeWhere( (Word word) => toRemove.contains(word));
      wordSuggestions.add(selectedWord);
      wordSuggestions.shuffle();
    }
  }

  setSuggestionChinese() async {
    if (allLanguages)
      wordSuggestions = await _studyService.getAllWordSuggestions();
    else
      wordSuggestions = await _studyService.getWordSuggestions(language);
    reversedWordSuggestions = [];
    wordSuggestions.forEach( (word) {reversedWordSuggestions.add(wordRevert(word));});
    wordSuggestions = await reversedWordSuggestions;
    tipNeeded = true;
    List<Word> toRemove = [];
    wordSuggestions.forEach( (Word w) {
      if(w.wordEnglish == selectedWord.wordEnglish)
        toRemove.add(w);
    });
    wordSuggestions.removeWhere( (Word word) => toRemove.contains(word));
    wordSuggestions.add(selectedWord);
    wordSuggestions.shuffle();
  }

  void ngOnInit() => getOverdueWords();

  void submit(response) {
    method = 'setFirstWord()';
    difficulty = _studyService.check(response, selectedWord, tipNeeded);
    this.response = selectedWord.wordEnglish;
    overdueWords.removeLast();
    colour = _studyService.setColour(difficulty);
    _studyService.afterStudying(selectedWord.wordId.toString(), difficulty.toString());
    onCheck = true;
  }

  ItemRenderer<dynamic> wordRenderer = (dynamic word) {
    return word.wordEnglish;
  };

  void selectSuggestion(Word word) {
    response = word.wordEnglish;
  }

  void onTabChange(TabChangeEvent event) {
  }

  Future<Null> clickTab() async {
    switch(tabIndex) {
      case 0:
        getOverdueWords();
        allLanguages = false;
        break;
      case 1:
        overdueWords = await _studyService.getAllOverdueWords();
        await overdueWords.shuffle();
        maxAmount = overdueWords.length;
        language = 'All';
        allLanguages = true;
        setFirstWord();
    }
  }
}