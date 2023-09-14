import 'package:dracula_gpt/src/repositories/message.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';

const uuid = Uuid();
var repository = MessageRepository();

class MessageService {
  Future<void> addMessage(String message, String role) async {
    var randomUUID = uuid.v4();

    var messages = await repository.fetchMessages();

    if (message == 'clear' && role == 'user') {
      repository.deleteAllMessages();
      return;
    }

    if (messages.length > 100) {
      repository.deleteMessage(messages.first.id);
    }

    var msg = Message.fromJson({
      'id': randomUUID,
      'content': message,
      'role': role,
      'timestamp': DateTime.now().toIso8601String(),
    });

    repository.saveMessage(msg);
  }

  Future<List<Message>> getMessages() {
    return repository.fetchMessages();
  }
}
