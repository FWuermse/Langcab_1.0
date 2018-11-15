import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:langcab_ui/src/message/message_service.dart';

@Component(
  selector: 'app-message',
  templateUrl: 'message_component.html',
  styleUrls: const ['message_component.css'],
  directives: const [
    routerDirectives,
    coreDirectives,
  ],
)

class MessageComponent {

  final MessageService messageService;
  MessageComponent(this.messageService);
}