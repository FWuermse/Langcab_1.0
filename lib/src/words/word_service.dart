import 'dart:async';
import 'package:angular/angular.dart';
import 'dart:convert';
import 'package:langcab_ui/src/login/auth_service.dart';
import 'package:langcab_ui/src/message/message.dart';
import 'package:langcab_ui/src/message/message_service.dart';
import 'word.dart';
import 'package:http/http.dart';


@Injectable()
class WordService {

//  static const _wordsUrl = 'http://localhost/api/word'; // URL to web API Dev
  static const _wordsUrl = 'https://www.langcab.com/api/word'; // URL to web API Prod
  int totalPages = 0;
  int currentPage = 0;

  final Client _http;
  final AuthService authService;
  final MessageService _messageService;
  WordService(this._http, AuthService this.authService, this._messageService);

  dynamic _extractData(Response resp) => jsonDecode(resp.body);

  Exception _handleError(dynamic e) {
    _messageService.add(new Message('An error occurred: ', '$e', 'danger'));
    return new Exception('Server error; cause: $e');
  }

  Future<List<Word>> getWords(String search, String language, String sort) async {
    String idToken = await authService.getToken();
    try {
      final response = await _http.get('$_wordsUrl/?search=$search&language=$language&page=$currentPage&sort=$sort,DESC', headers: {'Authorization': idToken});
      final words = _extractData(response);
      totalPages = words['totalPages'];
      currentPage = words['number']+1;
      return words['content']
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Word>> getWordsSearch(String search, String language, String sort) async {
    String idToken = await authService.getToken();
    try {
      final response = await _http.get('$_wordsUrl/?search=$search&language=$language&page=0&sort=$sort,DESC', headers: {'Authorization': idToken});
      final words = _extractData(response);
      totalPages = words['totalPages'];
      currentPage = words['number']+1;
      return words['content']
          .map<Word>((value) => new Word.fromJson(value))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<int> getWordsAmount(String search, String language) async {
    String idToken = await authService.getToken();
    try {
      final response = await _http.get('$_wordsUrl/?search=$search&language=$language&page=$currentPage', headers: {'Authorization': idToken});
      final words = _extractData(response);
      return words['totalElements'];
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Word> getWord(int wordId) async {
    String idToken = await authService.getToken();
    try {
      final response = await _http.get('$_wordsUrl/$wordId', headers: {'Authorization': idToken});
      return new Word.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> create(String wordEnglish, String wordPinyin, String wordChinese, String language) async {
    String idToken = await authService.getToken();
    try {
      await _http.post('$_wordsUrl/',
          headers: {'Authorization': idToken, 'Content-Type': 'application/json'}, body: jsonEncode( {
            'wordEnglish': wordEnglish,
            'wordPinyin': wordPinyin,
            'wordChinese': wordChinese,
            'language' : language
          }));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> update(Word hero) async {
    String idToken = await authService.getToken();
    try {
      final url = '$_wordsUrl/';
      await _http.put(url, headers: {'Authorization': idToken, 'Content-Type': 'application/json'}, body: jsonEncode(hero));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    String idToken = await authService.getToken();
    try {
      final url = '$_wordsUrl/$id';
      await _http.delete(url, headers: {'Authorization': idToken});
    } catch (e) {
      throw _handleError(e);
    }
  }
}