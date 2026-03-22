import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../shared/widgets/online_indicator.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../models/vendor_model.dart';
import '../../../services/vendor_service.dart';

class VendorDetailScreen extends StatefulWidget {
  const VendorDetailScreen({super.key});

  @override
  State<VendorDetailScreen> createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  final VendorService _vendorService = VendorService();
  Vendor? _vendor;
  bool _isLoading = true;
  String? _vendorId;

  @override
  void initState() {
    super.initState();
    _loadVendor();
  }

  void _loadVendor() async {
    // Get vendor ID from route parameters
    final uri = GoRouterState.of(context).uri;
    _vendorId = uri.pathSegments.last;
    
    setState(() => _isLoading = true);
    
    try {
      final vendor = await _vendorService.getVendorById(_vendorId!);
      if (mounted) {
        setState(() {
          _vendor = vendor;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.background, AppColors.surface],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      );
    }

    if (_vendor == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.background, AppColors.surface],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Vendor not found',
                  style: AppTypography.body1.copyWith(color: AppColors.error),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.surface],
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
                    Text('Vendor Profile', style: AppTypography.headline3),
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
                                backgroundImage: AssetImage(
                                  _vendor!.profileImage,
                                ),
                                backgroundColor: AppColors.card,
                              ),
                              OnlineIndicator(
                                isOnline: _vendor!.isOnline,
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
                                _vendor!.name,
                                style: AppTypography.headline1,
                              ),
                              const SizedBox(width: 8),
                              const VerifiedBadge(),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Gender and Age
                          Text(
                            '${_vendor!.gender} · ${_vendor!.age} yrs',
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
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _vendor!.rating.toStringAsFixed(1),
                                style: AppTypography.headline3.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${_vendor!.totalReviews} reviews)',
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Description
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.border.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              _vendor!.description,
                              style: AppTypography.body1.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Experience and Rate
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_vendor!.experienceHours}h',
                                    style: AppTypography.headline3.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Experience',
                                    style: AppTypography.body2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₹${_vendor!.ratePerMinute}',
                                    style: AppTypography.headline3.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Per minute',
                                    style: AppTypography.body2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Talk Now Button
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.primaryGradient,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => context.go('/chat/${_vendor!.id}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Talk Now',
                                style: AppTypography.buttonLarge.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
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
