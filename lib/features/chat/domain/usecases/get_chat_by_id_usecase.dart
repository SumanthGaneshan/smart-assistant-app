import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

class GetConversationByIdUseCase {
  final ChatRepository repository;

  GetConversationByIdUseCase(this.repository);

  Future<Conversation> call(String id) async {
    return await repository.getConversationById(id);
  }
}