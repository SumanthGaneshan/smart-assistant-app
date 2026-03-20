import '../models/chat_response_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatResponseModel> postMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<ChatResponseModel> postMessage(String message) async {

    await Future.delayed(const Duration(seconds: 2));

    return ChatResponseModel(
      status: "success",
      reply: "Mocking success! You said: '$message'. This is the assistant's reply.",
    );
  }
}