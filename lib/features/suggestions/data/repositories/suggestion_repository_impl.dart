import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion_pagination.dart';
import 'package:smart_assistant_app/features/suggestions/domain/respositories/suggestion_repository.dart';

import '../../domain/entities/suggestion.dart';
import '../datasources/suggestion_remote_datasource.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  final SuggestionRemoteDataSource remoteDataSource;

  SuggestionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<Suggestion>, SuggestionPagination)> getSuggestions({required int page}) async {
    final response = await remoteDataSource.fetchSuggestions(page: page, limit: 10);

    final List<Suggestion> suggestions = response.data.map((model) => model.toEntity()).toList();
    final SuggestionPagination pagination = response.pagination.toEntity();

    return (suggestions, pagination);
  }
}