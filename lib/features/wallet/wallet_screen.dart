import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/token_badge.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/token_service.dart';

class TokenPlan {
  final int price;
  final int tokens;
  final String? popularBadge;

  const TokenPlan({
    required this.price,
    required this.tokens,
    this.popularBadge,
  });
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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

  // Mock token plans with better value propositions
  final List<TokenPlan> _tokenPlans = [
    const TokenPlan(price: 50, tokens: 100),
    const TokenPlan(price: 100, tokens: 220, popularBadge: 'Popular'),
    const TokenPlan(price: 200, tokens: 500),
    const TokenPlan(price: 500, tokens: 1400, popularBadge: 'Best Value'),
  ];

  void _addTokens(int amount) {
    _tokenService.addTokens(amount);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $amount tokens to your wallet!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

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
                child: Row(
                  children: [
                    // Back Button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => context.go('/home'),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // History Button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Show transaction history
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Transaction history coming soon'),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.history_rounded,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Wallet Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Balance Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.primaryGradient,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Balance',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textInverse.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TokenBadge(tokenCount: _tokenService.tokens),
                                const SizedBox(width: 12),
                                Text(
                                  'tokens',
                                  style: AppTypography.body1.copyWith(
                                    color: AppColors.textInverse.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textInverse.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '1 token = 1 minute of call',
                                style: AppTypography.caption1.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Section Header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Purchase Tokens',
                          style: AppTypography.headline3,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose a plan that fits your needs',
                          style: AppTypography.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Token Plans Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: _tokenPlans.length,
                        itemBuilder: (context, index) {
                          final plan = _tokenPlans[index];
                          final isPopular = plan.popularBadge != null;

                          return Container(
                            decoration: BoxDecoration(
                              gradient: isPopular
                                  ? const LinearGradient(
                                      colors: AppColors.primaryGradient,
                                    )
                                  : const LinearGradient(
                                      colors: AppColors.cardGradient,
                                    ),
                              borderRadius: BorderRadius.circular(20),
                              border: isPopular
                                  ? null
                                  : Border.all(
                                      color: AppColors.border,
                                      width: 1,
                                    ),
                              boxShadow: [
                                BoxShadow(
                                  color: isPopular
                                      ? AppColors.primary.withValues(alpha: 0.3)
                                      : AppColors.shadow,
                                  blurRadius: isPopular ? 16 : 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Plan Content
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Popular Badge
                                      if (isPopular)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.textInverse
                                                .withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            plan.popularBadge!,
                                            style: AppTypography.caption1
                                                .copyWith(
                                                  color: AppColors.textInverse,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),

                                      if (isPopular) const SizedBox(height: 12),

                                      // Token Amount
                                      Text(
                                        '${plan.tokens}',
                                        style: AppTypography.token.copyWith(
                                          color: isPopular
                                              ? AppColors.textInverse
                                              : AppColors.textPrimary,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        'tokens',
                                        style: AppTypography.body2.copyWith(
                                          color: isPopular
                                              ? AppColors.textInverse
                                                    .withValues(alpha: 0.8)
                                              : AppColors.textSecondary,
                                        ),
                                      ),

                                      const Spacer(),

                                      // Price
                                      Text(
                                        '\$${plan.price}',
                                        style: AppTypography.price.copyWith(
                                          color: isPopular
                                              ? AppColors.textInverse
                                              : AppColors.primary,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      // Buy Button
                                      Container(
                                        width: double.infinity,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: isPopular
                                              ? AppColors.textInverse
                                              : AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            onTap: () =>
                                                _addTokens(plan.tokens),
                                            child: Center(
                                              child: Text(
                                                'Buy Now',
                                                style: AppTypography.buttonSmall
                                                    .copyWith(
                                                      color: isPopular
                                                          ? AppColors.primary
                                                          : AppColors
                                                                .textInverse,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),
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
