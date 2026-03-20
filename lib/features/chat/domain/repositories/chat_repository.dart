import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<({Message message, String conversationId})> sendMessage({
    String? conversationId,
    required String text
  });

  Future<List<Conversation>> getChatHistory();

  Future<Conversation> getConversationById(String id);
}