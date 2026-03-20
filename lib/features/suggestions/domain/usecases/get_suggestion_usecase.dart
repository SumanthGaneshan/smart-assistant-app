import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion.dart';
import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion_pagination.dart';
import 'package:smart_assistant_app/features/suggestions/domain/respositories/suggestion_repository.dart';

class GetSuggestionUseCase {
  final SuggestionRepository repository;
  GetSuggestionUseCase({required this.repository});


  Future<(List<Suggestion>,SuggestionPagination)> call(int page) async{
    return await repository.getSuggestions(page: page);
  }
}