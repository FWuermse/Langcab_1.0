import 'package:angular/angular.dart';
import 'package:langcab_ui/src/message/message.dart';

@Injectable()
class MessageService {

  List<Message> messages = [];

  add(Message message) {
    messages.add(message);
  }

  remove(Message message) {
    messages.remove(message);
  }
}