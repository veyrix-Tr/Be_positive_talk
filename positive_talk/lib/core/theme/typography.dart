import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  // Display styles - For hero sections and large headers
  static final TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1.0,
  );

  static final TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static final TextStyle displaySmall = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.25,
  );

  // Headline styles - For screen titles and section headers
  static final TextStyle headline1 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.25,
  );

  static final TextStyle headline2 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
    letterSpacing: -0.1,
  );

  static final TextStyle headline3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Title styles - For card titles and subtitles
  static final TextStyle title1 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.35,
    letterSpacing: -0.05,
  );

  static final TextStyle title2 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle title3 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body styles - For content text
  static final TextStyle body1 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
    letterSpacing: 0.05,
  );

  static final TextStyle body2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0.025,
  );

  static final TextStyle body3 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.45,
  );

  // Caption styles - For small labels and metadata
  static final TextStyle caption1 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textTertiary,
    height: 1.35,
    letterSpacing: 0.1,
  );

  static final TextStyle caption2 = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 0.15,
  );

  // Button styles - For interactive elements
  static final TextStyle buttonLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.8,
  );

  static final TextStyle buttonMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static final TextStyle buttonSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.3,
  );

  // Input field styles
  static final TextStyle inputLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.45,
    letterSpacing: 0.025,
  );

  static final TextStyle inputMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.025,
  );

  // Label styles - For form labels and tags
  static final TextStyle label = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // Specialized styles
  static final TextStyle price = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    height: 1.15,
    letterSpacing: -0.25,
  );

  static final TextStyle token = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0.1,
  );

  static final TextStyle status = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.6,
  );

  // Enhanced styles for specific use cases
  static final TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnCard,
    height: 1.3,
    letterSpacing: -0.025,
  );

  static final TextStyle cardSubtitle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.025,
  );

  static final TextStyle badge = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // Legacy compatibility for existing code
  static TextStyle get button => buttonLarge;
  static TextStyle get input => inputLarge;
}
