import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/features/chat/domain/usecases/get_chat_by_id_usecase.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetConversationByIdUseCase getConversationByIdUseCase;

  ChatBloc({required this.sendMessageUseCase,required this.getConversationByIdUseCase}) : super(ChatState.initial()) {
    on<ChatStarted>(_onChatStarted);
    on<MessageSent>(_onMessageSent);
    on<ConversationLoaded>(_onConversationLoaded);
  }

  Future<void> _onChatStarted(
      ChatStarted event,
      Emitter<ChatState> emit,
      ) async {
    emit(state.copyWith(
      status: ChatStatus.loading,
    ));
    await _sendMessage(event.message, emit);
  }


  Future<void> _onMessageSent(
      MessageSent event,
      Emitter<ChatState> emit,
      ) async {
    await _sendMessage(event.message, emit);
  }

  Future<void> _sendMessage(String text, Emitter<ChatState> emit) async {
    final userMessage = Message(
      id: "temp_${DateTime.now().millisecondsSinceEpoch}",
      text: text,
      sender: MessageSender.user,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(
      status: ChatStatus.success,
      messages: [...state.messages, userMessage],
      isTyping: true,
      error: null,
    ));

    try {
      final result = await sendMessageUseCase(
        conversationId: state.conversationId,
        text: text,
      );

      emit(state.copyWith(
        messages: [...state.messages, result.message],
        conversationId: result.conversationId,
        isTyping: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChatStatus.error,
        error: e.toString(),
        isTyping: false,
      ));
    }
  }

  Future<void> _onConversationLoaded(
      ConversationLoaded event,
      Emitter<ChatState> emit,
      ) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      final conversation = await getConversationByIdUseCase(event.conversationId);
      emit(state.copyWith(
        status: ChatStatus.success,
        messages: conversation.messages,
        conversationId: conversation.id,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChatStatus.error,
        error: e.toString(),
      ));
    }
  }
}