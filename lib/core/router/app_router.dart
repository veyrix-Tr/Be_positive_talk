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

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Authentication routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      GoRoute(path: '/otp', builder: (context, state) => const OTPScreen()),

      // Profile route
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileSetupScreen(),
      ),

      // Main app routes
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

      GoRoute(
        path: '/vendor',
        builder: (context, state) => const VendorDetailScreen(),
      ),

      GoRoute(
        path: '/wallet',
        builder: (context, state) => const WalletScreen(),
      ),

      GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),

      GoRoute(
        path: '/call',
        builder: (context, state) => const OngoingCallScreen(),
      ),

      GoRoute(
        path: '/call-summary',
        builder: (context, state) => const CallSummaryScreen(),
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
