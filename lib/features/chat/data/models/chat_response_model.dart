class ChatResponseModel {
  final String status;
  final String reply;

  ChatResponseModel({required this.status, required this.reply});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      status: json['status'] as String,
      reply: json['reply'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'reply': reply,
    };
  }
}