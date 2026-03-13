import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/enhanced_vendor_card.dart';
import '../../../shared/widgets/wallet_badge.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/token_service.dart';
import 'vendor_model.dart';
import 'inbox_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TokenService _tokenService = TokenService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tokenService.addListener(_onTokenServiceChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      name: 'Aashna',
      image: 'assets/profile1.png',
      ratePerMinute: 5,
      isOnline: true,
      description: 'Professional counselor with 5+ years experience',
      gender: 'F',
      age: 25,
      rating: 4.82,
      reviewCount: 3000,
      experienceHours: 1000,
    ),
    Vendor(
      id: '2',
      name: 'Mike Chen',
      image: 'assets/profile1.png',
      ratePerMinute: 8,
      isOnline: true,
      description: 'Tech support specialist',
      gender: 'M',
      age: 30,
      rating: 4.5,
      reviewCount: 2500,
      experienceHours: 1500,
    ),
    Vendor(
      id: '3',
      name: 'Emma Davis',
      image: 'assets/profile1.png',
      ratePerMinute: 6,
      isOnline: false,
      description: 'Life coach and mentor',
      gender: 'F',
      age: 28,
      rating: 4.9,
      reviewCount: 1800,
      experienceHours: 800,
    ),
    Vendor(
      id: '4',
      name: 'Alex Rodriguez',
      image: 'assets/profile1.png',
      ratePerMinute: 10,
      isOnline: true,
      description: 'Business consultant',
      gender: 'M',
      age: 35,
      rating: 4.7,
      reviewCount: 4200,
      experienceHours: 2000,
    ),
    Vendor(
      id: '5',
      name: 'Lisa Wang',
      image: 'assets/profile1.png',
      ratePerMinute: 7,
      isOnline: false,
      description: 'Career advisor and coach',
      gender: 'F',
      age: 32,
      rating: 4.6,
      reviewCount: 3100,
      experienceHours: 1200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
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
              // Header with Wallet Badge
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text('Welcome back!', style: AppTypography.headline3),
                    WalletBadge(amount: _tokenService.tokens.toDouble()),
                  ],
                ),
              ),

              // Tab Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Verified'),
                    Tab(text: 'Inbox'),
                  ],
                  labelStyle: AppTypography.title3,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    insets: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Verified Tab - Vendor List
                    ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _mockVendors.length,
                      itemBuilder: (context, index) {
                        final vendor = _mockVendors[index];
                        return EnhancedVendorCard(
                          vendor: vendor,
                          onTap: () => context.go('/vendor/${vendor.id}'),
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
    );
  }
}
