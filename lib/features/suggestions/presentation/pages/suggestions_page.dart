import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/features/suggestions/presentation/widgets/suggestion_top_bar.dart';
import '../../../../core/presentation/widgets/custom_bottom_input.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/suggestion.dart';
import '../bloc/suggestions_bloc.dart';
import '../bloc/suggestions_event.dart';
import '../bloc/suggestions_state.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<SuggestionsBloc>().add(FetchSuggestions(fetchMore: true));
    }
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    Navigator.pushNamed(
      context,
      AppRouter.chat,
      arguments: ChatArgs.newChat(message: text),
    );
    _inputController.clear();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hi User',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Your smart assistant is ready for action.',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall!.color,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'QUICK ACTIONS',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  BlocBuilder<SuggestionsBloc, SuggestionsState>(
                    builder: (context, state) {
                      final suggestions = state.suggestions;
                      final hasNext = state.pagination?.hasNext ?? false;

                      if (state.status == SuggestionsStatus.initial ||
                          (state.status == SuggestionsStatus.loading && suggestions.isEmpty)) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state.status == SuggestionsStatus.error && suggestions.isEmpty) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'Error: ${state.error}',
                            ),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            if (index >= suggestions.length) {
                              if(state.status == SuggestionsStatus.loading){
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                              return const SizedBox.shrink();
                            }

                            final item = suggestions[index];
                            return _buildSuggestionCard(item);
                          },
                          childCount: hasNext ? suggestions.length + 1 : suggestions.length,
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SuggestionTopBar(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomInput(
                controller: _inputController,
                onSend: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(Suggestion item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.chat,
          arguments: ChatArgs.newChat(message: item.title),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 20,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}