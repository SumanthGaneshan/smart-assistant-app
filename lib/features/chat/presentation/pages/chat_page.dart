import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/core/presentation/widgets/custom_bottom_input.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../../domain/entities/message.dart';

class ChatPage extends StatefulWidget {
  final String? initialMessage;
  final String? conversationId;

  const ChatPage({
    super.key,
    this.initialMessage,
    this.conversationId,
  }) : assert(
  initialMessage != null || conversationId != null,
  'Either initialMessage or conversationId must be provided',
  );

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialMessage != null) {
      context.read<ChatBloc>().add(
        ChatStarted(message: widget.initialMessage!),
      );
    } else {
      context.read<ChatBloc>().add(
        ConversationLoaded(conversationId: widget.conversationId!),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatBloc>().add(MessageSent(text));
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.status == ChatStatus.success) {
                  _scrollToBottom();
                }
                if (state.status == ChatStatus.error && state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                }
              },
              builder: (context, state) {
                if (state.status == ChatStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 100),
                  itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state.isTyping && index == state.messages.length) {
                      return const TypingIndicator();
                    }
                    final message = state.messages[index];
                    return MessageBubble(message: message);
                  },
                );
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return CustomBottomInput(
                  controller: _controller,
                  onSend: _sendMessage,
                  enabled: !state.isTyping,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}