abstract class ChatEvent {}

class ChatStarted extends ChatEvent {
  final String message;

  ChatStarted({required this.message});
}

class MessageSent extends ChatEvent {
  final String message;

  MessageSent(this.message);
}

class ConversationLoaded extends ChatEvent {
  final String conversationId;
  ConversationLoaded({required this.conversationId});
}