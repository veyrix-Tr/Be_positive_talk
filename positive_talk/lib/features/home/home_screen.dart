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
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 32), // Status bar height
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
                      Text(
                        'Positive Talk',
                        style: AppTypography.headline2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Spacer(),

                      // Wallet Badge
                      WalletBadge(),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          // Verified Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: _tabController.index == 0
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Verified',
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
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: _tabController.index == 1
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Inbox',
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
                                    valueColor: AppColors.primary,
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16.0),
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
