import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Premium navy/indigo theme
  static const Color primary = Color(0xFF4F46E5); // Professional indigo
  static const Color primaryVariant = Color(0xFF4338CA); // Deeper indigo
  static const Color primaryLight = Color(0xFF6366F1); // Lighter indigo
  static const Color primaryDark = Color(0xFF3730A3); // Darker indigo

  // Background colors - Sophisticated dark theme
  static const Color background = Color(0xFF0F0F1E); // Rich dark blue
  static const Color surface = Color(0xFF1E1E2E); // Elevated surface
  static const Color card = Color(0xFF252535); // Card surface
  static const Color cardHover = Color(0xFF2A2A3F); // Card hover state
  static const Color overlay = Color(0x990F0F1E); // Semi-transparent overlay

  // Text colors - Enhanced contrast and readability
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondary = Color(0xFFCBD5E1); // Soft blue-gray
  static const Color textTertiary = Color(0xFF94A3B8); // Muted blue-gray
  static const Color textInverse = Color(0xFF0F0F1E); // For colored backgrounds
  static const Color textOnCard = Color(0xFFE2E8F0); // Light text on cards

  // Accent colors - Vibrant and professional
  static const Color accent = Color(0xFF06B6D4); // Modern cyan
  static const Color accentLight = Color(0xFF22D3EE); // Bright cyan
  static const Color accentDark = Color(0xFF0891B2); // Darker cyan

  // Status colors - Clear semantic meaning
  static const Color success = Color(0xFF10B981); // Modern green
  static const Color successLight = Color(0xFF34D399); // Light green
  static const Color warning = Color(0xFFF59E0B); // Modern amber
  static const Color warningLight = Color(0xFFFCD34D); // Light amber
  static const Color error = Color(0xFFEF4444); // Modern red
  static const Color errorLight = Color(0xFFF87171); // Light red
  static const Color info = Color(0xFF3B82F6); // Information blue

  // Border and divider colors - Subtle and elegant
  static const Color border = Color(0xFF334155); // Subtle border
  static const Color borderLight = Color(0xFF475569); // Lighter border
  static const Color divider = Color(0xFF1E293B); // Divider
  static const Color outline = Color(0xFF475569); // Outline color

  // Status indicators
  static const Color online = Color(0xFF10B981); // Green for online
  static const Color offline = Color(0xFF6B7280); // Gray for offline
  static const Color away = Color(0xFFF59E0B); // Amber for away
  static const Color busy = Color(0xFFEF4444); // Red for busy

  // Special colors - Glassmorphism and effects
  static const Color glass = Color(0x1AFFFFFF); // Glass effect
  static const Color shadow = Color(0x1A000000); // Shadow color
  static const Color shadowLight = Color(0x0D000000); // Light shadow
  static const Color shimmer = Color(0xFFE2E8F0); // Shimmer effect

  // Gradient colors - Rich and vibrant
  static const List<Color> primaryGradient = [
    Color(0xFF4F46E5),
    Color(0xFF7C3AED),
    Color(0xFF06B6D4),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF252535),
    Color(0xFF2A2A3F),
    Color(0xFF1E1E2E),
  ];

  static const List<Color> accentGradient = [
    Color(0xFF06B6D4),
    Color(0xFF22D3EE),
  ];

  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF34D399),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFF59E0B),
    Color(0xFFFCD34D),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFEF4444),
    Color(0xFFF87171),
  ];
}
