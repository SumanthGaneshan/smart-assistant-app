import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion_pagination.dart';

import '../../domain/entities/suggestion.dart';

enum SuggestionsStatus { initial, loading, success, error }

class SuggestionsState {
  final SuggestionsStatus status;
  final List<Suggestion> suggestions;
  final SuggestionPagination? pagination;
  final String? error;


  const SuggestionsState({
    required this.status,
    required this.suggestions,
    this.pagination,
    this.error
  });

  factory SuggestionsState.initial(){
    return SuggestionsState(
        status: SuggestionsStatus.initial,
        suggestions: [],
        pagination: null,
        error: null,
    );
  }

  SuggestionsState copyWith({
    SuggestionsStatus? status,
    List<Suggestion>? suggestions,
    SuggestionPagination? pagination,
    String? error,
  }) {
    return SuggestionsState(
      status: status ?? this.status,
      suggestions: suggestions ?? this.suggestions,
      pagination: pagination ?? this.pagination,
      error: error ?? this.error,
    );
  }
}