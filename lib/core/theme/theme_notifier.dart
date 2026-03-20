import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

const _themeBoxName = 'settings';
const _themeKey = 'themeMode';

Future<void> initTheme() async {
  final box = await Hive.openBox(_themeBoxName);
  final index = box.get(_themeKey, defaultValue: ThemeMode.dark.index) as int;
  themeNotifier.value = ThemeMode.values[index];
}

Future<void> setTheme(ThemeMode mode) async {
  themeNotifier.value = mode;
  final box = Hive.box(_themeBoxName);
  await box.put(_themeKey, mode.index);
}