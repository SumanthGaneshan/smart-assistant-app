import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/features/chat/presentation/bloc/history/history_bloc.dart';
import 'package:smart_assistant_app/features/chat/presentation/pages/chat_history_page.dart';
import 'package:smart_assistant_app/features/chat/presentation/pages/chat_page.dart';
import 'package:smart_assistant_app/features/suggestions/presentation/pages/suggestions_page.dart';

import '../../features/chat/presentation/bloc/chat/chat_bloc.dart';
import '../../features/suggestions/presentation/bloc/suggestions_bloc.dart';
import '../di/injection_container.dart';
import '../presentation/pages/bottom_nav_page.dart';

class AppRouter {
  static const String home = '/';
  static const String chat = '/chat';
  static const String history = '/history';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const BottomNavPage(),
        );

      case AppRouter.chat:
        final args = settings.arguments as ChatArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ChatBloc>(),
            child: ChatPage(
              initialMessage: args.initialMessage,
              conversationId: args.conversationId,
            ),
          ),
        );

      case history:
        return MaterialPageRoute(
          builder: (_)=> BlocProvider(
            create: (_)=> sl<HistoryBloc>(),
            child: ChatHistoryPage(),
          )
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}

class ChatArgs {
  final String? initialMessage;
  final String? conversationId;

  const ChatArgs.newChat({required String message})
      : initialMessage = message,
        conversationId = null;

  const ChatArgs.existingChat({required String id})
      : conversationId = id,
        initialMessage = null;
}