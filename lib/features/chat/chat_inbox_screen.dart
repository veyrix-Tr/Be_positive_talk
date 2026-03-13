import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';

class ChatInboxScreen extends StatelessWidget {
  const ChatInboxScreen({super.key});

  // Mock chat history data
  List<ChatMessage> get _mockMessages => [
    ChatMessage(
      id: '1',
      vendorName: 'Aashna',
      vendorImage: 'assets/profile1.png',
      lastMessage: '🙂 Let\'s make you HAPPY!',
      date: 'Mar 5, 2026',
      isVerified: true,
      isUnread: true,
    ),
    ChatMessage(
      id: '2',
      vendorName: 'Mike Chen',
      vendorImage: 'assets/profile1.png',
      lastMessage: 'How can I help you today?',
      date: 'Mar 4, 2026',
      isVerified: true,
      isUnread: false,
    ),
    ChatMessage(
      id: '3',
      vendorName: 'Emma Davis',
      vendorImage: 'assets/profile1.png',
      lastMessage: 'Looking forward to our session',
      date: 'Mar 3, 2026',
      isVerified: true,
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'Inbox',
          style: AppTypography.headline3,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _mockMessages.length,
        itemBuilder: (context, index) {
          final message = _mockMessages[index];
          return _ChatMessageTile(
            message: message,
            onTap: () => context.go('/chat/${message.id}'),
          );
        },
      ),
    );
  }
}

class _ChatMessageTile extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onTap;

  const _ChatMessageTile({
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(message.vendorImage),
            ),
            
            const SizedBox(width: 12),
            
            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        message.vendorName,
                        style: AppTypography.title2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const VerifiedBadge(size: 10),
                      if (message.isUnread) ...[
                        const Spacer(),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.lastMessage,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.date,
                    style: AppTypography.caption1.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String id;
  final String vendorName;
  final String vendorImage;
  final String lastMessage;
  final String date;
  final bool isVerified;
  final bool isUnread;

  ChatMessage({
    required this.id,
    required this.vendorName,
    required this.vendorImage,
    required this.lastMessage,
    required this.date,
    required this.isVerified,
    required this.isUnread,
  });
}
