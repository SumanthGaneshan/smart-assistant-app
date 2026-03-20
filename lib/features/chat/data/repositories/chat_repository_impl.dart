import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/conversation_hive_model.dart';
import '../models/message_hive_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;
  final ChatLocalDataSource local;

  ChatRepositoryImpl({required this.remote, required this.local});

  @override
  Future<({Message message, String conversationId})> sendMessage({String? conversationId, required String text}) async {

    final String currentId = conversationId ?? DateTime.now().millisecondsSinceEpoch.toString();

    final userMessage = Message(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      text: text,
      sender: MessageSender.user,
      createdAt: DateTime.now(),
    );


    if (conversationId == null) {
      await local.cacheConversation(ConversationHiveModel(
        id: currentId,
        title: text,
        messages: [MessageHiveModel.fromEntity(userMessage)],
        lastUpdatedAt: DateTime.now(),
      ));
    } else {
      final existing = await local.getConversation(currentId);
      if (existing != null) {
        final updatedMessages = [
          ...existing.messages,
          MessageHiveModel.fromEntity(userMessage),
        ];
        await local.cacheConversation(ConversationHiveModel(
          id: existing.id,
          title: existing.title,
          messages: updatedMessages,
          lastUpdatedAt: DateTime.now(),
        ));
      }
    }

    final response = await remote.postMessage(text);

    final assistantMessage = Message(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      text: response.reply,
      sender: MessageSender.assistant,
      createdAt: DateTime.now(),
    );

    final currentChat = await local.getConversation(currentId);
    if (currentChat != null) {
      currentChat.messages.add(MessageHiveModel.fromEntity(assistantMessage));
      await local.cacheConversation(currentChat);
    }

    return (message: assistantMessage, conversationId: currentId);
  }

  @override
  Future<List<Conversation>> getChatHistory() async {
    final hiveModels = await local.getChatHistory();
    final conversations = hiveModels.map((m) => m.toEntity()).toList();

    conversations.sort((a, b) => b.lastUpdatedAt.compareTo(a.lastUpdatedAt));

    return conversations;
  }

  @override
  Future<Conversation> getConversationById(String id) async {
    final model = await local.getConversation(id);
    if (model == null) throw Exception("Conversation not found");
    return model.toEntity();
  }
}