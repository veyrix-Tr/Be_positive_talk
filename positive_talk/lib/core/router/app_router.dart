import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/auth/profile_setup_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/vendor/vendor_detail_screen.dart';
import '../../features/wallet/wallet_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/call/ongoing_call_screen.dart';
import '../../features/call/call_summary_screen.dart';
import '../../features/refer/refer_and_earn_screen.dart';
import '../../features/usage/usage_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/usercare/user_care_screen.dart';
import '../../features/profile/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Authentication routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      GoRoute(path: '/otp', builder: (context, state) => const OTPScreen()),

      // Profile setup route
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Main app routes
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

      GoRoute(
        path: '/vendor/:id',
        builder: (context, state) => const VendorDetailScreen(),
      ),

      GoRoute(
        path: '/wallet',
        builder: (context, state) => const WalletScreen(),
      ),

      GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),

      GoRoute(
        path: '/chat/:id',
        builder: (context, state) => const ChatScreen(),
      ),

      GoRoute(
        path: '/call',
        builder: (context, state) => const OngoingCallScreen(),
      ),

      GoRoute(
        path: '/call/:id',
        builder: (context, state) => const OngoingCallScreen(),
      ),

      GoRoute(
        path: '/call-summary',
        builder: (context, state) => const CallSummaryScreen(),
      ),

      // New feature routes
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: '/refer',
        builder: (context, state) => const ReferAndEarnScreen(),
      ),

      GoRoute(path: '/usage', builder: (context, state) => const UsageScreen()),

      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        path: '/user-care',
        builder: (context, state) => const UserCareScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.uri}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}
