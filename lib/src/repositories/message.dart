import 'dart:convert';

import 'package:dracula_gpt/src/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageRepository {
  void saveMessage(Message message) async {
    final prefs = await SharedPreferences.getInstance();

    final messages = prefs.getStringList('messages') ?? [];

    messages.add(message.toString());

    await prefs.setStringList(
      'messages',
      messages,
    );
  }

  Future<List<Message>> fetchMessages() async {
    final prefs = await SharedPreferences.getInstance();

    final messages = prefs.getStringList('messages') ?? [];

    return messages
        .map((messageString) => Message.fromJson(jsonDecode(messageString)))
        .toList();
  }

  void deleteMessage(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final messages = prefs.getStringList('messages') ?? [];

    messages.removeWhere((messageString) =>
        Message.fromJson(jsonDecode(messageString)).id == id);

    await prefs.setStringList(
      'messages',
      messages,
    );
  }

  void deleteAllMessages() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'messages',
      [],
    );
  }
}
