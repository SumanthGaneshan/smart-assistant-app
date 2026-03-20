import 'package:hive/hive.dart';

import '../../domain/entities/message.dart';
part 'message_hive_model.g.dart';

@HiveType(typeId: 0)
class MessageHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String sender;

  @HiveField(3)
  final DateTime createdAt;

  MessageHiveModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
  });

  Message toEntity() => Message(
    id: id,
    text: text,
    sender: sender == 'user' ? MessageSender.user : MessageSender.assistant,
    createdAt: createdAt,
  );

  factory MessageHiveModel.fromEntity(Message entity) => MessageHiveModel(
    id: entity.id,
    text: entity.text,
    sender: entity.sender == MessageSender.user ? 'user' : 'assistant',
    createdAt: entity.createdAt,
  );
}