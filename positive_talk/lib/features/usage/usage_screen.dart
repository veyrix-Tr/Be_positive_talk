import 'package:flutter/material.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../services/usage_service.dart';

class UsageScreen extends StatelessWidget {
  const UsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsageRecord>>(
      future: UsageService().getUsageHistory(),
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
                  'Error loading usage data',
                  style: AppTypography.body1.copyWith(color: AppColors.error),
                ),
              ],
            ),
          );
        }

        final usageRecords = snapshot.data ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: usageRecords.length,
          itemBuilder: (context, index) {
            final record = usageRecords[index];
            return _UsageRecordTile(record: record);
          },
        );
      },
    );
  }
}

class _UsageRecordTile extends StatelessWidget {
  final UsageRecord record;

  const _UsageRecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            backgroundImage: const AssetImage('assets/profile1.png'),
            backgroundColor: AppColors.card,
          ),

          const SizedBox(width: 12),

          // Usage Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vendor Name and Duration
                Row(
                  children: [
                    Text(
                      record.vendorName,
                      style: AppTypography.title2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${record.duration.inMinutes} min',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Tokens Used
                Row(
                  children: [
                    Text(
                      '${record.tokensUsed} tokens',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'used',
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Date
                Text(
                  record.date,
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textTertiary,
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
