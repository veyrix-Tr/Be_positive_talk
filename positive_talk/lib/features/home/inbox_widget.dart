import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/chat_service.dart';

class InboxWidget extends StatelessWidget {
  const InboxWidget({super.key});

  // Service instance
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InboxChat>>(
      future: _chatService.getInboxChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Error loading chats',
                  style: AppTypography.body1.copyWith(color: AppColors.error),
                ),
              ],
            ),
          );
        }

        final inboxChats = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: inboxChats.length,
          itemBuilder: (context, index) {
            final chat = inboxChats[index];
            return _ChatMessageTile(
              chat: chat,
              onTap: () => context.go('/chat/${chat.vendorId}'),
            );
          },
        );
      },
    );
  }
}

class _ChatMessageTile extends StatelessWidget {
  final InboxChat chat;
  final VoidCallback onTap;

  const _ChatMessageTile({required this.chat, required this.onTap});

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
              backgroundImage: AssetImage(chat.vendorImage),
              backgroundColor: AppColors.card,
            ),

            const SizedBox(width: 12),

            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vendor Name and Verified Badge
                  Row(
                    children: [
                      Text(
                        chat.vendorName,
                        style: AppTypography.title2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const VerifiedBadge(size: 10),
                      if (chat.isUnread) ...[
                        const SizedBox(width: 8),
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

                  // Last Message
                  Text(
                    chat.lastMessage,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Date and Unread Indicator
                  Row(
                    children: [
                      Text(
                        chat.date,
                        style: AppTypography.caption1.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      if (chat.isUnread) ...[
                        const SizedBox(width: 8),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InboxChat {
  final String id;
  final String vendorId;
  final String vendorName;
  final String vendorImage;
  final String lastMessage;
  final String date;
  final bool isVerified;
  final bool isUnread;

  InboxChat({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.vendorImage,
    required this.lastMessage,
    required this.date,
    required this.isVerified,
    required this.isUnread,
  });
}
