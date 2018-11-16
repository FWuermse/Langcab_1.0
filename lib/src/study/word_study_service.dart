import 'dart:async';
import 'package:angular/angular.dart';
import 'dart:convert';
import 'package:langcab_ui/src/login/auth_service.dart';
import 'package:langcab_ui/src/message/message.dart';
import 'package:langcab_ui/src/message/message_service.dart';
import 'package:langcab_ui/src/study/levenshtein.dart';
import 'package:http/http.dart';
import 'package:langcab_ui/src/words/word.dart';

@Injectable()
class StudyService {
//  static const _studyUrl = 'http://localhost/api/learn'; // URL to web API Dev
  static const _studyUrl = 'https://www.langcab.com/api/learn'; // URL to web API Prod

  final Client _http;
  final AuthService authService;
  final MessageService _messageService;
  StudyService(this._http, AuthService this.authService, this._messageService);

  Future<List<Word>> getOverdueWords(String language) async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_studyUrl/?language=$language', headers: {'Authorization': idToken});
      _checkResponse(response);
      final List<Word> words = _extractData(response)
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
      return words;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Word>> getWordSuggestions(String language) async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_studyUrl/choice?language=$language', headers: {'Authorization': idToken});
      _checkResponse(response);
      final List<Word> words = _extractData(response)
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
      return words;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Word>> getAllWordSuggestions() async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_studyUrl/choice/all', headers: {'Authorization': idToken});
      _checkResponse(response);
      final List<Word> words = _extractData(response)
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
      return words;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Word>> getAllOverdueWords() async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_studyUrl/all', headers: {'Authorization': idToken});
      _checkResponse(response);
      final List<Word> words = _extractData(response)
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
      return words;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<int> getOverdueWordsAmount() async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_studyUrl/all/amount', headers: {'Authorization': idToken});
      _checkResponse(response);
      final words = _extractData(response);
      return words['totalElements'];
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> afterStudying(String wordId, String difficulty) async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.post('$_studyUrl/',
          headers: {'Authorization': idToken, 'Content-Type': 'application/json'},
          body: jsonEncode({'id': wordId, 'di': difficulty}));
      _checkResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => jsonDecode(resp.body);

  Exception _handleError(dynamic e) {
    print(e);
    _messageService.add(new Message('An error occurred: ', '$e', 'danger'));
    return new Exception('Server error; cause: $e');
  }

  void _checkResponse(Response response) {
    if (response.statusCode != 200) {
      dynamic decodedResponse = jsonDecode(response.body);
      throw new Exception('Status: ${decodedResponse["status"]} Error: ${decodedResponse["error"]}');
    }
  }

  int check(String response, Word selectedWord, bool tipNeeded) {
    Levenshtein levenshtein = new Levenshtein();
    int difference = levenshtein.getDifference(response.replaceAll(new RegExp(r"\s+\b|\b\s"), ""), selectedWord.wordEnglish.replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
    if (tipNeeded) {
      if (difference < 1)
        return 3;
      else
        return 1;
    } else if (selectedWord.wordEnglish.length > 25) {
      if (difference == 1 || difference == 2 || difference == 3)
        return 4;
      else if (difference > 3)
        return 1;
    } else if (selectedWord.wordEnglish.length > 11) {
      if (difference == 1 || difference == 2)
        return 4;
      else if (difference > 2)
        return 1;
    } else if (selectedWord.wordEnglish.length > 5) {
      if (difference == 1)
        return 4;
      else if (difference > 1)
        return 1;
    } else {
      if (difference > 0)
        return 1;
    }
    return 5;
  }

  String setColour(int difficulty) {
    if (difficulty <= 1)
      return 'text-white bg-danger';
    else
      return 'text-white bg-success';
  }

  int calculateProgress(int maxAmount, int amount) {
    if (amount == 0)
      return 100;
    else {
      int wordsDone = maxAmount - amount;
      double average = wordsDone / maxAmount;
      double percent = average * 100;
      return percent.round().toInt();
    }
  }
}