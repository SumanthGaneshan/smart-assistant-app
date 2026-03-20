import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/suggestion_response.dart';

class SuggestionRemoteDataSource {
  Future<SuggestionResponse> fetchSuggestions({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    final String response = await rootBundle.loadString('assets/data/suggestions.json');
    final Map<String, dynamic> fullData = json.decode(response);
    final List<dynamic> allItems = fullData['suggestions'];

    final int totalItems = allItems.length;
    final int totalPages = (totalItems / limit).ceil();
    final int startIndex = (page - 1) * limit;
    final int endIndex = startIndex + limit;

    final List<dynamic> pagedItems = allItems.sublist(
      startIndex,
      endIndex > totalItems ? totalItems : endIndex,
    );

    final mockJsonResponse = {
      "status": "success",
      "data": pagedItems,
      "pagination": {
        "current_page": page,
        "total_pages": totalPages,
        "total_items": totalItems,
        "limit": limit,
        "has_next": page < totalPages,
        "has_previous": page > 1
      }
    };

    return SuggestionResponse.fromJson(mockJsonResponse);
  }
}