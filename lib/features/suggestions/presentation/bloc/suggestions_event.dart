abstract class SuggestionsEvent {}

class FetchSuggestions extends SuggestionsEvent{
  final bool fetchMore;
  FetchSuggestions({this.fetchMore = false});
}