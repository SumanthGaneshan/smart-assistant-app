import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
import '../../../../main.dart';
import '../bloc/history/history_bloc.dart';
import '../bloc/history/history_event.dart';
import '../bloc/history/history_state.dart';
import '../../domain/entities/conversation.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(HistoryFetched());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<HistoryBloc>().add(HistoryFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat History')),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state.status == HistoryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.conversations.isEmpty) {
            return const Center(child: Text('No conversations yet.'));
          } else if (state.status == HistoryStatus.error) {
            return Center(child: Text(state.error ?? 'Something went wrong.'));
          } else if (state.status == HistoryStatus.success) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return _ConversationTile(conversation: conversation);
              },
            );
          }
          return Center(child: Text(state.error ?? 'Something went wrong.'));
        },
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conversation;

  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final lastMessage = conversation.messages.isNotEmpty
        ? conversation.messages.last.text
        : 'No messages';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.chat,
          arguments: ChatArgs.existingChat(id: conversation.id),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            Text(
              _formatDate(conversation.lastUpdatedAt),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
