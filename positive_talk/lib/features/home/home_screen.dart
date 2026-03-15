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

  // Service instances
  final VendorService _vendorService = VendorService();

  // State for vendors
  List<Vendor> _vendors = [];
  bool _isLoadingVendors = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    _loadVendors();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section - Header with Wallet Badge and Drawer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.surface,
                    AppColors.surface.withValues(alpha: 0.85),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Hamburger Menu
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: const Icon(
                            Icons.menu,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Title
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Positive Talk',
                            style: AppTypography.headline3.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Find verified listeners',
                            style: AppTypography.caption1.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
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

            // Bottom Section - Tab Bar and Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // Tab Bar
                    Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Row(
                        children: [
                          // Verified Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  gradient: _tabController.index == 0
                                      ? const LinearGradient(
                                          colors: AppColors.primaryGradient,
                                        )
                                      : null,
                                  color: _tabController.index == 0
                                      ? null
                                      : AppColors.card.withValues(alpha: 0.35),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: _tabController.index == 0
                                        ? AppColors.primary.withValues(
                                            alpha: 0.25,
                                          )
                                        : AppColors.border.withValues(
                                            alpha: 0.25,
                                          ),
                                  ),
                                ),
                                child: Text(
                                  'Verified',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.buttonMedium.copyWith(
                                    color: _tabController.index == 0
                                        ? AppColors.textInverse
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 2),

                          // Inbox Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  gradient: _tabController.index == 1
                                      ? const LinearGradient(
                                          colors: AppColors.primaryGradient,
                                        )
                                      : null,
                                  color: _tabController.index == 1
                                      ? null
                                      : AppColors.card.withValues(alpha: 0.35),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: _tabController.index == 1
                                        ? AppColors.primary.withValues(
                                            alpha: 0.25,
                                          )
                                        : AppColors.border.withValues(
                                            alpha: 0.25,
                                          ),
                                  ),
                                ),
                                child: Text(
                                  'Inbox',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.buttonMedium.copyWith(
                                    color: _tabController.index == 1
                                        ? AppColors.textInverse
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tab Indicator
                    Container(
                      height: 3,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),

                    // Tab Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Verified Tab - Vendor List
                          _isLoadingVendors
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    16.0,
                                    12.0,
                                    16.0,
                                    24.0,
                                  ),
                                  itemCount: _vendors.length,
                                  itemBuilder: (context, index) {
                                    final vendor = _vendors[index];
                                    return EnhancedVendorCard(
                                      vendor: vendor,
                                      onTap: () =>
                                          context.go('/vendor/${vendor.id}'),
                                    );
                                  },
                                ),

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
}
