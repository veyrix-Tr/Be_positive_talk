import 'package:flutter/material.dart';
import '../../features/home/vendor_model.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';

class HostCard extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback onTap;

  const HostCard({super.key, required this.vendor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Image
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(vendor.image),
                ),
                // Online status indicator
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: vendor.isOnline
                          ? AppColors.online
                          : AppColors.offline,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // Vendor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vendor.name, style: AppTypography.title1),
                  const SizedBox(height: 4),
                  Text(
                    'Rate: ${vendor.ratePerMinute} tokens/min',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Chat Button
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to chat with vendor
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chat feature coming soon')),
                    );
                  },
                  icon: Icon(
                    Icons.chat_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                // Call Button
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to call with vendor
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Call feature coming soon')),
                    );
                  },
                  icon: Icon(
                    Icons.call_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
