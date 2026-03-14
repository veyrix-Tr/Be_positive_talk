import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/vendor_model.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'verified_badge.dart';
import 'online_indicator.dart';

class EnhancedVendorCard extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback onTap;

  const EnhancedVendorCard({
    super.key,
    required this.vendor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Profile Image and Verified Badge
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(vendor.profileImage),
                      backgroundColor: AppColors.card,
                    ),
                    OnlineIndicator(isOnline: vendor.isOnline, size: 12),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(vendor.name, style: AppTypography.title1),
                          const SizedBox(width: 8),
                          const VerifiedBadge(size: 10),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${vendor.gender} · ${vendor.age} yrs',
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Rating and Reviews
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      vendor.rating.toStringAsFixed(2),
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${vendor.totalReviews}+)',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${vendor.experienceHours}+ hrs',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              vendor.description,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Talk Now Button
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => context.go('/vendor/${vendor.id}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TALK NOW',
                      style: AppTypography.buttonMedium.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
