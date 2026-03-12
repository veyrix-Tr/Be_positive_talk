import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/token_badge.dart';
import '../../../shared/widgets/host_card.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/token_service.dart';
import 'vendor_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TokenService _tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    _tokenService.addListener(_onTokenServiceChanged);
  }

  @override
  void dispose() {
    _tokenService.removeListener(_onTokenServiceChanged);
    super.dispose();
  }

  void _onTokenServiceChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // Mock vendor data
  List<Vendor> get _mockVendors => [
    Vendor(
      id: '1',
      name: 'Sarah Johnson',
      image: 'assets/profile1.png',
      ratePerMinute: 5,
      isOnline: true,
      description: 'Professional counselor with 5+ years experience',
    ),
    Vendor(
      id: '2',
      name: 'Mike Chen',
      image: 'assets/profile1.png',
      ratePerMinute: 8,
      isOnline: true,
      description: 'Tech support specialist',
    ),
    Vendor(
      id: '3',
      name: 'Emma Davis',
      image: 'assets/profile1.png',
      ratePerMinute: 6,
      isOnline: false,
      description: 'Life coach and mentor',
    ),
    Vendor(
      id: '4',
      name: 'Alex Rodriguez',
      image: 'assets/profile1.png',
      ratePerMinute: 10,
      isOnline: true,
      description: 'Business consultant',
    ),
    Vendor(
      id: '5',
      name: 'Lisa Wang',
      image: 'assets/profile1.png',
      ratePerMinute: 7,
      isOnline: false,
      description: 'Career advisor and coach',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              // Modern Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Top bar with greeting and profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Greeting
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good morning',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Welcome back!',
                              style: AppTypography.headline3,
                            ),
                          ],
                        ),

                        // Profile button
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppColors.primaryGradient,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Navigate to profile
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile coming soon'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.person_rounded,
                              size: 24,
                              color: AppColors.textInverse,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Token Balance Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryGradient,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your Balance',
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textInverse.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.go('/wallet');
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TokenBadge(tokenCount: _tokenService.tokens),
                              const SizedBox(width: 8),
                              Text(
                                'tokens',
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textInverse.withValues(
                                    alpha: 0.8,
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

              // Vendor List Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available Experts',
                            style: AppTypography.headline3,
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Show all vendors
                            },
                            child: Text(
                              'See all',
                              style: AppTypography.buttonMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Vendor List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: _mockVendors.length,
                        itemBuilder: (context, index) {
                          final vendor = _mockVendors[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HostCard(
                              vendor: vendor,
                              onTap: () {
                                context.go('/vendor');
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
