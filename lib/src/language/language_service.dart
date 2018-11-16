import 'dart:async';
import 'dart:convert';
import 'package:angular/di.dart';
import 'package:http/http.dart';
import 'package:langcab_ui/src/login/auth_service.dart';
import 'package:langcab_ui/src/message/message.dart';
import 'package:langcab_ui/src/message/message_service.dart';

@Injectable()
class LanguageService {
//  static const _wordsUrl = 'http://localhost/api/language'; // URL to web API Dev
  static const _wordsUrl = 'https://www.langcab.com/api/language'; // URL to web Prod
  final Client _http;
  final AuthService authService;
  final MessageService _messageService;
  LanguageService(this._http, AuthService this.authService, this._messageService);

  String _language;

  void setLanguage(String language) {
    _language = language;
  }

  Future<String> getLanguage() async {
    if (_language != null)
      return _language;
    else {
      String lang = await getLastLanguage();
      setLanguage(lang);
      return lang;
    }
  }

  Exception _handleError(dynamic e) {
    _messageService.add(new Message('An error occurred: ', '$e', 'danger'));
    return new Exception('Server error; cause: $e');
  }

  dynamic _extractData(Response resp) => jsonDecode(resp.body).cast<String>();

  Future<String> getLastLanguage() async {
    String idToken = await authService.getToken();
    try {
      final Response response = await _http.get('$_wordsUrl/last', headers: {'Authorization': idToken});
      if (response.statusCode != 200) {
        try {
          var errorList = jsonDecode(response.body);
          if (errorList['message'] == 'Welcome! Start by adding your first word.')
            _messageService.add(new Message('Info: ', errorList['message'], 'info'));
          else
            _messageService.add(new Message('An error occurred: ', errorList['message'], 'error'));
        } catch (e) {
          _messageService.add(new Message('An error occurred: ', '${response.reasonPhrase} ${response.statusCode}', 'danger'));
        }
        return "";
      }
      else
        return(response.body);
    } catch (e) {
      throw _handleError(jsonDecode(e));
    }
  }

  Future<List<String>> getMyLanguages() async {
    String idToken = await authService.getToken();
    try {
      final response = await _http.get('$_wordsUrl/mine', headers: {'Authorization': idToken});
      if (response.statusCode != 200) {
        try {
          var errorList = jsonDecode(response.body);
          if (errorList['message'] == 'Please add a new language first')
            _messageService.add(new Message('Info: ', errorList['message'], 'info'));
          else
            _messageService.add(new Message('An error occurred: ', errorList['message'], 'error'));
        } catch (e) {
          _messageService.add(new Message('An error occurred: ', '${response.reasonPhrase} ${response.statusCode}', 'danger'));
        }
        return [""];
      }
      else
        return _extractData(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
}