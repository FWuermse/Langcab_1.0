import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import 'package:langcab_ui/src/edit/word_detail_component.dart';
import 'package:langcab_ui/src/language/language_service.dart';
import 'package:langcab_ui/src/message/message_service.dart';
import 'word.dart';
import 'package:angular_router/angular_router.dart';
import 'package:langcab_ui/src/words/word_service.dart';
import '../../route_paths.dart';

@Component(
  selector: 'my-words',
  templateUrl: 'words_component.html',
  styleUrls: const ['words_component.css'],
  directives: const [
    coreDirectives,
    routerDirectives,
    WordDetailComponent,
    LanguageService,
    MessageService
  ],
  preserveWhitespace: true,
  pipes: const [commonPipes],
)
class WordsComponent implements OnInit {
  List<Word> words = [];
  Word selectedWord;
  String idToken;
  String searchString = '';
  String language;
  String sort = 'timeCreated';
  bool button = true;

  final Logger log = new Logger('WordComponent');
  final WordService _wordService;
  final LanguageService _languageService;
  WordsComponent(this._wordService, this._languageService);

  String wordEnglish = '';
  String wordPinyin = '';
  String wordChinese = '';

  preparePage() async {
    scroll();
    language = await _languageService.getLanguage();
    getWords();
    if (window.screen.available.width < 370)
      button = false;
    else
      button = true;
  }

  Future<Null> getWords() async {
    words = (await _wordService.getWordsSearch(searchString, language, sort));
  }

  Future<Null> addGetWords() async {
    if (_wordService.currentPage > _wordService.totalPages)
      log.fine('no more pages with the current filter');
    else
      words.addAll(await _wordService.getWords(searchString, language, sort));
  }

  void ngOnInit() => preparePage();

  String editUrl(Word word) =>
      RoutePaths.edit.toUrl(parameters: {idParam: '${word.wordId}'});

  String gotoAddDetail() =>
      RoutePaths.add.toUrl();

  Future<Null> delete(Word word) async {
    await _wordService.delete(word.wordId);
    getWords();
  }

  Future<Null> onKey(KeyboardEvent event) async {
    searchString = event.toString();
    getWords();

  }

  void scroll() {
    _updateScrollInfo([_]) {
      if (window.innerHeight + window.scrollY >= document.body.clientHeight) {
        addGetWords();
      }
    }
    window.onScroll.listen(_updateScrollInfo);
    window.onResize.listen(_updateScrollInfo);
  }
}