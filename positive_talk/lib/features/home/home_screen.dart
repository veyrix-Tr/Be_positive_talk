import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/enhanced_vendor_card.dart';
import '../../../shared/widgets/wallet_badge.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/vendor_service.dart';
import '../../../models/vendor_model.dart';
import 'inbox_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _headerAnimationController;
  late Animation<double> _headerSlideAnimation;

  // Service instances
  final VendorService _vendorService = VendorService();

  // State for vendors
  List<Vendor> _vendors = [];
  bool _isLoadingVendors = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Header animation
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _headerSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _tabController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    _loadVendors();

    // Start header animation
    _headerAnimationController.forward();
  }

  Future<void> _loadVendors() async {
    setState(() => _isLoadingVendors = true);
    try {
      final vendors = await _vendorService.getVerifiedVendors();
      if (mounted) {
        setState(() {
          _vendors = vendors;
          _isLoadingVendors = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingVendors = false);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _headerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Animated Header Section
            AnimatedBuilder(
              animation: _headerSlideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1.0 - _headerSlideAnimation.value) * -20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.surface,
                          AppColors.surface.withValues(alpha: 0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 60,
                          offset: const Offset(0, 30),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Hamburger Menu
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.card.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.border.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Builder(
                                builder: (context) => IconButton(
                                  onPressed: () =>
                                      Scaffold.of(context).openDrawer(),
                                  icon: const Icon(
                                    Icons.menu_rounded,
                                    color: AppColors.textPrimary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // Title Section
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Positive Talk',
                                  style: AppTypography.headline2.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
                                        AppColors.accent.withValues(alpha: 0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Find verified listeners',
                                    style: AppTypography.caption1.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Wallet Badge
                            WalletBadge(amount: 150.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // Main Content Area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 40,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Modern Tab Bar
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        24.0,
                        20.0,
                        24.0,
                        12.0,
                      ),
                      child: Row(
                        children: [
                          // Verified Tab
                          Expanded(
                            child: _buildTab(
                              title: 'Verified',
                              isActive: _tabController.index == 0,
                              onTap: () => _tabController.animateTo(0),
                              icon: Icons.verified_rounded,
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Inbox Tab
                          Expanded(
                            child: _buildTab(
                              title: 'Inbox',
                              isActive: _tabController.index == 1,
                              onTap: () => _tabController.animateTo(1),
                              icon: Icons.chat_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tab Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Verified Tab - Vendor List
                          _isLoadingVendors
                              ? _buildLoadingState()
                              : _buildVendorList(),

                          // Inbox Tab - Chat History
                          const InboxWidget(),
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
      drawer: const AppDrawer(),
    );
  }

  Widget _buildTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : LinearGradient(
                  colors: [
                    AppColors.card.withValues(alpha: 0.3),
                    AppColors.card.withValues(alpha: 0.1),
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.border.withValues(alpha: 0.2),
            width: 2,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : AppColors.textSecondary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTypography.buttonMedium.copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary, strokeWidth: 3),
          const SizedBox(height: 16),
          Text(
            'Loading verified listeners...',
            style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
      itemCount: _vendors.length,
      itemBuilder: (context, index) {
        final vendor = _vendors[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: EnhancedVendorCard(
            vendor: vendor,
            onTap: () => context.go('/vendor/${vendor.id}'),
          ),
        );
      },
    );
  }
}
