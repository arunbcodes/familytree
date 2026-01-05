import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the current theme mode
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
