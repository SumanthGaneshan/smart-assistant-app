
import '../../../domain/entities/conversation.dart';

enum HistoryStatus { initial, loading, success, error }

class HistoryState {
  final HistoryStatus status;
  final List<Conversation> conversations;
  final String? error;

  const HistoryState({
    required this.status,
    required this.conversations,
    this.error,
  });

  factory HistoryState.initial() {
    return const HistoryState(
      status: HistoryStatus.initial,
      conversations: [],
    );
  }

  HistoryState copyWith({
    HistoryStatus? status,
    List<Conversation>? conversations,
    String? error,
  }) {
    return HistoryState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      error: error ?? this.error,
    );
  }
}