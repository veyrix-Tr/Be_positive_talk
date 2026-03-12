import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Deep violet/indigo theme
  static const Color primary = Color(0xFF6366F1); // Modern indigo
  static const Color primaryVariant = Color(0xFF4F46E5); // Deeper indigo
  static const Color primaryLight = Color(0xFF818CF8); // Lighter indigo

  // Background colors - Very dark neutral
  static const Color background = Color(0xFF0A0A0F); // Very dark
  static const Color surface = Color(0xFF1A1A23); // Slightly lighter dark
  static const Color card = Color(0xFF252530); // Card surface
  static const Color cardHover = Color(0xFF2A2A35); // Card hover state

  // Text colors - High contrast
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondary = Color(0xFFA1A1AA); // Muted gray
  static const Color textTertiary = Color(0xFF71717A); // More muted
  static const Color textInverse = Color(0xFF0A0A0F); // For colored backgrounds

  // Accent colors - Modern palette
  static const Color accent = Color(0xFF22D3EE); // Modern cyan
  static const Color accentLight = Color(0xFF67E8F9); // Light cyan

  // Status colors - Clear semantic meaning
  static const Color success = Color(0xFF10B981); // Modern green
  static const Color successLight = Color(0xFF34D399); // Light green
  static const Color warning = Color(0xFFF59E0B); // Modern amber
  static const Color warningLight = Color(0xFFFCD34D); // Light amber
  static const Color error = Color(0xFFEF4444); // Modern red
  static const Color errorLight = Color(0xFFF87171); // Light red

  // Border and divider colors - Subtle
  static const Color border = Color(0xFF3F3F46); // Subtle border
  static const Color borderLight = Color(0xFF4F4F56); // Lighter border
  static const Color divider = Color(0xFF2A2A2F); // Divider

  // Status indicators
  static const Color online = Color(0xFF10B981); // Green for online
  static const Color offline = Color(0xFF6B7280); // Gray for offline
  static const Color away = Color(0xFFF59E0B); // Amber for away

  // Special colors
  static const Color shadow = Color(0x1A000000); // Shadow color
  static const Color overlay = Color(0x800A0A0F); // Overlay for modals

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF252530),
    Color(0xFF2A2A35),
  ];
}
