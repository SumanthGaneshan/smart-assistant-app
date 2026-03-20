import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_assistant_app/features/chat/presentation/pages/chat_history_page.dart';

import '../../../features/chat/presentation/bloc/history/history_bloc.dart';
import '../../../features/chat/presentation/bloc/history/history_event.dart';
import '../../../features/suggestions/presentation/bloc/suggestions_bloc.dart';
import '../../../features/suggestions/presentation/bloc/suggestions_event.dart';
import '../../../features/suggestions/presentation/pages/suggestions_page.dart';
import '../../di/injection_container.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (_) => sl<SuggestionsBloc>()..add(FetchSuggestions()),
      child: const SuggestionsPage(),
    ),
    BlocProvider(
      create: (_) => sl<HistoryBloc>()..add(HistoryFetched()),
      child: const ChatHistoryPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history_rounded),
          label: 'History',
        ),
      ],
    );
  }
}