import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class GetChatHistoryUseCase {
  final ChatRepository repository;

  GetChatHistoryUseCase(this.repository);

  Future<List<Conversation>> call() async {
    return await repository.getChatHistory();
  }
}