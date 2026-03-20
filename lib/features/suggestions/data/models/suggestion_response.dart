import 'package:smart_assistant_app/features/suggestions/domain/entities/suggestion_pagination.dart';

import 'suggestion_model.dart';

class SuggestionResponse {
  final String status;
  final List<SuggestionModel> data;
  final SuggestionPaginationModel pagination;

  SuggestionResponse({
    required this.status,
    required this.data,
    required this.pagination,
  });

  factory SuggestionResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => SuggestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: SuggestionPaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>),
    );
  }
}

class SuggestionPaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;
  final bool hasNext;
  final bool hasPrevious;

  SuggestionPaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory SuggestionPaginationModel.fromJson(Map<String, dynamic> json) {
    return SuggestionPaginationModel(
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalItems: json['total_items'] as int? ?? 0,
      limit: json['limit'] as int? ?? 10,
      hasNext: json['has_next'] as bool? ?? false,
      hasPrevious: json['has_previous'] as bool? ?? false,
    );
  }

  SuggestionPagination toEntity() {
    return SuggestionPagination(
      currentPage: currentPage,
      hasNext: hasNext,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}