import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:langcab_ui/route_paths.dart';
import 'package:langcab_ui/src/words/word.dart';
import 'package:langcab_ui/src/words/word_service.dart';

@Component(
  selector: 'word-detail',
  templateUrl: 'word_detail_component.html',
  styleUrls: const ['../add/word_add_component.css'],
  directives: const [
    formDirectives,
    coreDirectives,
    AutoFocusDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    materialInputDirectives,
  ],
)
class WordDetailComponent implements OnActivate {
  Word word;
  final WordService _wordService;
  final Location _location;

  String label = "Translation";

  WordDetailComponent(this._wordService, this._location);

  @override
  void onActivate(_, RouterState current) async {
    final wordId = getId(current.parameters);
    if (wordId != null) word = await (_wordService.getWord(wordId));
  }

  Future<Null> save() async {
    await _wordService.update(word);
    goBack();
  }

  void goBack() => _location.back();
}
