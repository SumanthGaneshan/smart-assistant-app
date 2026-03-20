class SuggestionPagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNext;

  const SuggestionPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
  });
}