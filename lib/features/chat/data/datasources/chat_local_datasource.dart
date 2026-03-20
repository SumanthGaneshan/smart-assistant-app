import 'package:hive/hive.dart';
import '../models/conversation_hive_model.dart';

abstract class ChatLocalDataSource {
  Future<void> cacheConversation(ConversationHiveModel conversation);
  Future<ConversationHiveModel?> getConversation(String id);
  Future<List<ConversationHiveModel>> getChatHistory();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box<ConversationHiveModel> box;

  ChatLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheConversation(ConversationHiveModel conversation) async {
    await box.put(conversation.id, conversation);
  }

  @override
  Future<ConversationHiveModel?> getConversation(String id) async {
    return box.get(id);
  }

  @override
  Future<List<ConversationHiveModel>> getChatHistory() async {
    return box.values.toList();
  }
}