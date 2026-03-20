import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_notifier.dart';

class SuggestionTopBar extends StatelessWidget {
  const SuggestionTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1A2E)
            : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 18,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Smart Assistant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _showSettingsPopup(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.settings,
                size: 20,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsPopup(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 80,
        100,
        16,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Theme.of(context).colorScheme.surface,
      elevation: 8,
      items: [
        PopupMenuItem(
          enabled: false,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, themeMode, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ThemeOption(
                    icon: Icons.light_mode_outlined,
                    label: 'Light',
                    isSelected: themeMode == ThemeMode.light,
                    onTap: () {
                      Navigator.pop(context);
                      setTheme(ThemeMode.light);
                    },
                  ),
                  _ThemeOption(
                    icon: Icons.dark_mode_outlined,
                    label: 'Dark',
                    isSelected: themeMode == ThemeMode.dark,
                    onTap: () {
                      Navigator.pop(context);
                      setTheme(ThemeMode.dark);
                    },
                  ),
                  _ThemeOption(
                    icon: Icons.phone_android_outlined,
                    label: 'System',
                    isSelected: themeMode == ThemeMode.system,
                    onTap: () {
                      Navigator.pop(context);
                      setTheme(ThemeMode.system);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary.withOpacity(0.4)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? AppTheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppTheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check, size: 16, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}