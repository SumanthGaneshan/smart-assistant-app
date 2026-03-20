import 'package:hive/hive.dart';

import '../../domain/entities/conversation.dart';
import 'message_hive_model.dart';

part 'conversation_hive_model.g.dart';

@HiveType(typeId: 1)
class ConversationHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<MessageHiveModel> messages;

  @HiveField(3)
  final DateTime lastUpdatedAt;

  ConversationHiveModel({
    required this.id,
    required this.title,
    required this.messages,
    required this.lastUpdatedAt,
  });


  Conversation toEntity() {
    return Conversation(
      id: id,
      title: title,
      messages: messages.map((msg) => msg.toEntity()).toList(),
      lastUpdatedAt: lastUpdatedAt,
    );
  }


  factory ConversationHiveModel.fromEntity(Conversation entity) {
    return ConversationHiveModel(
      id: entity.id,
      title: entity.title,
      messages: entity.messages
          .map((msg) => MessageHiveModel.fromEntity(msg))
          .toList(),
      lastUpdatedAt: entity.lastUpdatedAt,
    );
  }
}