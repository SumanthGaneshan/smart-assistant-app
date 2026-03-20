import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:smart_assistant_app/features/chat/domain/usecases/get_chat_by_id_usecase.dart';
import '../../features/chat/data/datasources/chat_local_datasource.dart';
import '../../features/chat/data/datasources/chat_remote_datasource.dart';
import '../../features/chat/data/models/conversation_hive_model.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/get_chat_history_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/presentation/bloc/chat/chat_bloc.dart';
import '../../features/chat/presentation/bloc/history/history_bloc.dart';
import '../../features/suggestions/data/datasources/suggestion_remote_datasource.dart';
import '../../features/suggestions/data/repositories/suggestion_repository_impl.dart';
import '../../features/suggestions/domain/respositories/suggestion_repository.dart';
import '../../features/suggestions/domain/usecases/get_suggestion_usecase.dart';
import '../../features/suggestions/presentation/bloc/suggestions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature - Suggestion

  sl.registerFactory(() => SuggestionsBloc(sl()));

  sl.registerLazySingleton(() => GetSuggestionUseCase(repository: sl()));

  sl.registerLazySingleton<SuggestionRepository>(
        () => SuggestionRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => SuggestionRemoteDataSource());



  // Feature - Chat

  sl.registerFactory(() => ChatBloc(sendMessageUseCase: sl(),getConversationByIdUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(()=>GetConversationByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetChatHistoryUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(remote: sl(), local: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl());
  sl.registerLazySingleton<ChatLocalDataSource>(() => ChatLocalDataSourceImpl(box: sl()));


  final conversationsBox = await Hive.openBox<ConversationHiveModel>('conversations');
  sl.registerLazySingleton(() => conversationsBox);


  // history
  // BLoC
  sl.registerFactory(() => HistoryBloc(getChatHistoryUseCase: sl()));
}