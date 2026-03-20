import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'features/chat/data/models/conversation_hive_model.dart';
import 'features/chat/data/models/message_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageHiveModelAdapter());
  Hive.registerAdapter(ConversationHiveModelAdapter());
  await initTheme();
  await init();
  runApp(const MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Smart Assistant',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.home,
          navigatorObservers: [routeObserver],
        );
      },
    );
  }
}
