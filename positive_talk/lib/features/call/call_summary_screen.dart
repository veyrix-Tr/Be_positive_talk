import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/theme/typography.dart';
import '../../../services/token_service.dart';

class CallSummaryScreen extends StatefulWidget {
  const CallSummaryScreen({super.key});

  @override
  State<CallSummaryScreen> createState() => _CallSummaryScreenState();
}

class _CallSummaryScreenState extends State<CallSummaryScreen> {
  final TokenService _tokenService = TokenService();
  late CallSessionData _sessionData;

  @override
  void initState() {
    super.initState();
    // Use the last call session data from TokenService
    // In a real app, this would be passed as a parameter or stored in state
    _sessionData = CallSessionData(
      duration: _tokenService.callDuration,
      tokensUsed: _tokenService.tokensUsed,
      remainingTokens: _tokenService.tokens,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Call Ended Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                    width: 3,
                  ),
                ),
                child: Icon(Icons.check_circle, size: 60, color: Colors.green),
              ),

              const SizedBox(height: 40),

              // Call Ended Text
              Text('Call Ended', style: AppTypography.headline1),

              const SizedBox(height: 40),

              // Call Details Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    // Vendor Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vendor', style: AppTypography.body2),
                        Text('Sarah Johnson', style: AppTypography.body1),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duration', style: AppTypography.body2),
                        Text(
                          _sessionData.formattedDuration,
                          style: AppTypography.body1,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Tokens Used
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tokens Used', style: AppTypography.body2),
                        Text(
                          '${_sessionData.tokensUsed}',
                          style: AppTypography.body1.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Remaining Tokens
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Remaining Tokens', style: AppTypography.body2),
                        Text(
                          '${_sessionData.remainingTokens}',
                          style: AppTypography.body1.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Return to Home Button
              PrimaryButton(
                text: 'Return to Home',
                onPressed: () {
                  context.go('/home');
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
