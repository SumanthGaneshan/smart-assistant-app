import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/features/suggestions/domain/usecases/get_suggestion_usecase.dart';

import 'package:smart_assistant_app/features/suggestions/presentation/bloc/suggestions_event.dart';
import 'package:smart_assistant_app/features/suggestions/presentation/bloc/suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent,SuggestionsState>{
  final GetSuggestionUseCase getSuggestionUseCase;

  SuggestionsBloc(this.getSuggestionUseCase) : super(SuggestionsState.initial()){
    on<FetchSuggestions>(_onFetchSuggestions);
  }

  Future<void> _onFetchSuggestions(
      FetchSuggestions event,
      Emitter<SuggestionsState> emit,
      ) async {
    if (state.status == SuggestionsStatus.loading) return;

    if (event.fetchMore && state.pagination != null && !state.pagination!.hasNext) {
      return;
    }

    emit(state.copyWith(status: SuggestionsStatus.loading));

    try {
      final int nextPage = event.fetchMore ? (state.pagination?.currentPage ?? 0) + 1 : 1;

      final (newSuggestions, pagination) = await getSuggestionUseCase(nextPage);

      emit(state.copyWith(
        status: SuggestionsStatus.success,
        suggestions: event.fetchMore ? [...state.suggestions, ...newSuggestions] : newSuggestions,
        pagination: pagination,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SuggestionsStatus.error,
        error: e.toString(),
      ));
    }
  }
}