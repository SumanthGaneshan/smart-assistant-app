import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion.dart';
import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion_pagination.dart';

abstract class SuggestionRepository {
  Future<(List<Suggestion>,SuggestionPagination)> getSuggestions({required int page});
}