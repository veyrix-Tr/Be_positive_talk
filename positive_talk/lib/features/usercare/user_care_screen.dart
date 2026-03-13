import 'package:flutter/material.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';

class UserCareScreen extends StatelessWidget {
  const UserCareScreen({super.key});

  // Mock FAQ data
  List<FAQItem> get _mockFAQs => [
    FAQItem(
      question: 'How do tokens work?',
      answer: 'Tokens are used to pay for calls and chats. Each vendor has a different rate per minute.',
    ),
    FAQItem(
      question: 'How do I add tokens to my wallet?',
      answer: 'You can purchase tokens through the wallet screen using various payment methods.',
    ),
    FAQItem(
      question: 'Is my conversation private?',
      answer: 'Yes, all conversations are end-to-end encrypted and completely private.',
    ),
    FAQItem(
      question: 'How do I report an issue?',
      answer: 'You can contact our support team through the email option below.',
    ),
    FAQItem(
      question: 'Can I change my display name?',
      answer: 'Yes, you can change your display name in the profile settings.',
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
          'User Care',
          style: AppTypography.headline3,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'How can we help you?',
              style: AppTypography.headline2,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Find answers to common questions or contact our support team.',
              style: AppTypography.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: AppTypography.title1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // FAQ List
            ..._mockFAQs.map((faq) => _FAQTile(faq: faq)),
            
            const SizedBox(height: 32),
            
            // Contact Support Section
            Text(
              'Still need help?',
              style: AppTypography.title1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Contact Options
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  // Email Support
                  ListTile(
                    leading: Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    title: Text(
                      'Email Support',
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'support@positivetalk.com',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textTertiary,
                      size: 16,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email client opening...')),
                      );
                    },
                  ),
                  
                  const Divider(),
                  
                  // Live Chat Support
                  ListTile(
                    leading: Icon(
                      Icons.chat_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    title: Text(
                      'Live Chat Support',
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Chat with our support team',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textTertiary,
                      size: 16,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Live chat coming soon')),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Contact Button
            PrimaryButton(
              text: 'Contact Support',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Support form opening...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQTile extends StatefulWidget {
  final FAQItem faq;

  const _FAQTile({required this.faq});

  @override
  State<_FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<_FAQTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.faq.question,
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: AppColors.textSecondary,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                widget.faq.answer,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
