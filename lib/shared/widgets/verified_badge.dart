import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class VerifiedBadge extends StatelessWidget {
  final double? size;

  const VerifiedBadge({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_rounded,
            color: AppColors.primary,
            size: size ?? 12,
          ),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: AppTypography.caption1.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: size != null ? size! * 0.8 : 10,
            ),
          ),
        ],
      ),
    );
  }
}
