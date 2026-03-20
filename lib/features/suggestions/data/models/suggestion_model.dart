import '../../domain/entities/suggestion.dart';

class SuggestionModel {
  final int id;
  final String title;
  final String description;
  final String icon;

  SuggestionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  Suggestion toEntity() {
    return Suggestion(
      id: id,
      title: title,
      description: description,
      icon: icon,
    );
  }
}