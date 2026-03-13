import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class OnlineIndicator extends StatelessWidget {
  final double? size;
  final bool isOnline;

  const OnlineIndicator({
    super.key, 
    this.size,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: size ?? 12,
        height: size ?? 12,
        decoration: BoxDecoration(
          color: isOnline ? AppColors.success : AppColors.offline,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.card,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isOnline 
                  ? AppColors.success.withValues(alpha: 0.4)
                  : Colors.transparent,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
