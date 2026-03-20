import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<({Message message, String conversationId})>  call({String? conversationId, required String text}) async {
    return await repository.sendMessage(
        conversationId: conversationId,
        text: text
    );
  }
}