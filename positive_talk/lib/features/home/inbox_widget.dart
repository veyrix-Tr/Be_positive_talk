import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/verified_badge.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/chat_service.dart';
import '../../../models/inbox_chat_model.dart';

class InboxWidget extends StatelessWidget {
  const InboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ChatService().getInboxChats(),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Ink(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.card.withValues(alpha: 0.8),
                  AppColors.surface.withValues(alpha: 0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(chat.vendorImage),
                      backgroundColor: AppColors.card,
                    ),
                    if (chat.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.online,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.background,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                // Message Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    chat.vendorName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.title2.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const VerifiedBadge(size: 10),
                              ],
                            ),
                          ),
                          Text(
                            chat.formattedDate,
                            style: AppTypography.caption1.copyWith(
                              color: AppColors.textTertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.lastMessage,
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.35,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat.unreadCount > 0) ...[
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                chat.unreadCount > 99
                                    ? '99+'
                                    : chat.unreadCount.toString(),
                                style: AppTypography.caption2.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
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
        ),
      ),
    );
  }
}
