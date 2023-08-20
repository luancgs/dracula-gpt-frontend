class GptResponse {
  final String message;

  GptResponse({
    required this.message,
  });

  factory GptResponse.fromJson(Map<String, dynamic> json) {
    return GptResponse(
      message: json['message'],
    );
  }
}
