import '../../../domain/entities/message.dart';

enum ChatStatus { initial, loading, success, error }

class ChatState {
  final ChatStatus status;
  final List<Message> messages;
  final String? conversationId;
  final bool isTyping;
  final String? error;

  const ChatState({
    required this.status,
    required this.messages,
    this.conversationId,
    this.isTyping = false,
    this.error,
  });

  factory ChatState.initial() {
    return const ChatState(
      status: ChatStatus.initial,
      messages: [],
      isTyping: false,
    );
  }

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? conversationId,
    bool? isTyping,
    String? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      isTyping: isTyping ?? this.isTyping,
      error: error ?? this.error,
    );
  }
}