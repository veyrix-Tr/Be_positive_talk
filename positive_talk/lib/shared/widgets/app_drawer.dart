import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: const AssetImage('assets/profile1.png'),
                  backgroundColor: AppColors.card,
                ),
                const SizedBox(height: 12),
                Text('Anonymous', style: AppTypography.title1),
                const SizedBox(height: 4),
                Text(
                  '+91 98765 43210',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerMenuItem(
                  icon: Icons.person_outline,
                  title: 'My Profile',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    context.go('/profile');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.star_outline,
                  title: 'Only for you',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon')),
                    );
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.share_outlined,
                  title: 'Refer and Earn',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    context.go('/refer');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.chat_outlined,
                  title: 'Communicate',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon')),
                    );
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.support_agent_outlined,
                  title: 'User Care',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    context.go('/user-care');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    context.go('/settings');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon')),
                    );
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.history_outlined,
                  title: 'Usage',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    context.go('/usage');
                  },
                ),
                _DrawerMenuItem(
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon')),
                    );
                  },
                ),
              ],
            ),
          ),

          // App Version
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'App Version',
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '1.0.0',
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary, size: 24),
      title: Text(
        title,
        style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}
