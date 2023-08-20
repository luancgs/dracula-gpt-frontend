import 'dart:convert';

import 'package:dracula_gpt/src/models/gpt_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.post(Uri.parse('http://localhost:3000/query'),
        headers: {'Content-Type': 'text/plain'}, body: textController.text);

    if (response.statusCode == 200) {
      widget
          .updateText(GptResponse.fromJson(jsonDecode(response.body)).message);
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
