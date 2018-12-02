import 'dart:async';

import 'package:angular/angular.dart';
import 'package:langcab_ui/src/message/message.dart';

@Injectable()
class MessageService {

  List<Message> messages = [];

  add(Message message) async {
    messages.add(message);
    await new Future.delayed(const Duration(milliseconds: 3500));
    remove(message);
  }

  remove(Message message) {
    messages.remove(message);
  }
}