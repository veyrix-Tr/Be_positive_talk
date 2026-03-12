import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';

class TokenBadge extends StatelessWidget {
  final int tokenCount;
  final double? size;

  const TokenBadge({super.key, required this.tokenCount, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('💰', style: TextStyle(fontSize: size ?? 16)),
          const SizedBox(width: 6),
          Text(
            '$tokenCount Tokens',
            style: AppTypography.caption1.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: size ?? 12,
            ),
          ),
        ],
      ),
    );
  }
}
