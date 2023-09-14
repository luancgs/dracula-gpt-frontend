import 'dart:convert';

import 'package:dracula_gpt/src/models/gpt_response.dart';
import 'package:dracula_gpt/src/services/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var messageService = MessageService();

class MessageInput extends StatefulWidget {
  final Function(String) updateText;
  const MessageInput({super.key, required this.updateText});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void callApi() async {
    var userMessage = textController.text;
    final response = await http.post(Uri.parse('http://localhost:3000/query'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'prompt': userMessage,
          'context': await messageService.getMessages()
        }));

    if (response.statusCode == 200) {
      var gptMessage = GptResponse.fromJson(jsonDecode(response.body)).message;
      widget.updateText(gptMessage);

      await messageService.addMessage(userMessage, 'user');
      await messageService.addMessage(gptMessage, 'assistant');
    } else {
      widget.updateText("Erro na requisição");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter your message',
          ),
          controller: textController,
        )),
        TextButton(
          onPressed: callApi,
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}
