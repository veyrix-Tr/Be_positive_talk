import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/typography.dart';
import '../../../services/token_service.dart';

class OngoingCallScreen extends StatefulWidget {
  const OngoingCallScreen({super.key});

  @override
  State<OngoingCallScreen> createState() => _OngoingCallScreenState();
}

class _OngoingCallScreenState extends State<OngoingCallScreen> {
  final TokenService _tokenService = TokenService();
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _tokenService.startCall();
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

      // Auto navigate to call summary when tokens are exhausted
      if (_tokenService.isTokensExhausted && _tokenService.isCallActive) {
        _endCall();
      }
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _endCall() {
    _tokenService.stopCall();
    context.go('/call-summary');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top Section - Call Duration
              const SizedBox(height: 40),

              Text(
                CallSessionData(
                  duration: _tokenService.callDuration,
                  tokensUsed: _tokenService.tokensUsed,
                  remainingTokens: _tokenService.tokens,
                ).formattedDuration,
                style: AppTypography.headline3.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Remaining Tokens: ${_tokenService.tokens}',
                style: AppTypography.body1.copyWith(
                  color: _tokenService.isTokensExhausted
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                ),
              ),

              const Spacer(),

              // Center Section - Vendor Info
              CircleAvatar(
                radius: 100,
                backgroundImage: const AssetImage('assets/profile1.png'),
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),

              const SizedBox(height: 32),

              Text('Sarah Johnson', style: AppTypography.headline1),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Connected',
                    style: AppTypography.body2.copyWith(color: Colors.green),
                  ),
                ],
              ),

              const Spacer(),

              // Bottom Section - Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute Button
                  GestureDetector(
                    onTap: _toggleMute,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: _isMuted
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.2)
                            : Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isMuted
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        _isMuted ? Icons.mic_off : Icons.mic,
                        size: 28,
                        color: _isMuted
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),

                  // End Call Button
                  GestureDetector(
                    onTap: _endCall,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(Icons.call_end, size: 28, color: Colors.red),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Button Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _isMuted ? 'Unmute' : 'Mute',
                    style: AppTypography.caption1.copyWith(
                      color: _isMuted
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'End Call',
                    style: AppTypography.caption1.copyWith(color: Colors.red),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
