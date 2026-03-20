import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_chat_history_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetChatHistoryUseCase getChatHistoryUseCase;

  HistoryBloc({required this.getChatHistoryUseCase}) : super(HistoryState.initial()) {
    on<HistoryFetched>(_onHistoryFetched);
  }

  Future<void> _onHistoryFetched(
      HistoryFetched event,
      Emitter<HistoryState> emit,
      ) async {
    emit(state.copyWith(status: HistoryStatus.loading));
    try {
      final conversations = await getChatHistoryUseCase();

      emit(state.copyWith(
        status: HistoryStatus.success,
        conversations: conversations
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HistoryStatus.error,
        error: e.toString(),
      ));
    }
  }
}