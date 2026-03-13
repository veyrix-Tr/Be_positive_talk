import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../shared/widgets/online_indicator.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../home/vendor_model.dart';

class VendorDetailScreen extends StatelessWidget {
  const VendorDetailScreen({super.key});

  // Mock vendor data - in real app, this would come from route parameters
  Vendor get _mockVendor => Vendor(
    id: '1',
    name: 'Aashna',
    image: 'assets/profile1.png',
    ratePerMinute: 5,
    isOnline: true,
    gender: 'F',
    age: 25,
    rating: 4.82,
    reviewCount: 3000,
    experienceHours: 1000,
    description:
        'Professional counselor with 5+ years experience in career guidance and personal development.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/home'),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Vendor Profile',
                      style: AppTypography.headline3,
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              const Spacer(),

              // Profile Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Top Section - Vendor Profile
                      Column(
                        children: [
                          // Avatar with Online Indicator
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 76,
                                backgroundImage: AssetImage(_mockVendor.image),
                                backgroundColor: AppColors.card,
                              ),
                              OnlineIndicator(
                                isOnline: _mockVendor.isOnline,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Name and Verified Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _mockVendor.name,
                                style: AppTypography.headline1,
                              ),
                              const SizedBox(width: 8),
                              const VerifiedBadge(),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Gender and Age
                          Text(
                            '${_mockVendor.gender} · ${_mockVendor.age} yrs',
                            style: AppTypography.body1.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Rating and Reviews
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.warning,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _mockVendor.rating.toStringAsFixed(2),
                                style: AppTypography.title1.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${_mockVendor.reviewCount}+)',
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Experience
                          Text(
                            '${_mockVendor.experienceHours}+ hrs',
                            style: AppTypography.body1.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Middle Section - Description
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: AppTypography.title3.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _mockVendor.description,
                              style: AppTypography.body1.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Bottom Section - Action Buttons
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Rate: ${_mockVendor.ratePerMinute} tokens/min',
                              style: AppTypography.body1.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: AppColors.primaryGradient,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => context.go('/chat/${_mockVendor.id}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.chat_outlined,
                                            color: AppColors.textInverse,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'CHAT NOW',
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
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: AppColors.primaryGradient,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => context.go('/call/${_mockVendor.id}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.call_outlined,
                                            color: AppColors.textInverse,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'CALL NOW',
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
