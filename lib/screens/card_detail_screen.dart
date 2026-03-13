import 'package:flutter/material.dart';
import '../models/reward_card_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/reward_card.dart';
import '../screens/member_code_screen.dart';

class CardDetailScreen extends StatelessWidget {
  final RewardCardModel card;

  const CardDetailScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final remainingPoints = card.targetPoints - card.currentPoints;
    final isUnlocked = remainingPoints <= 0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailTopBar(card: card),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: RewardCard(card: card),
              ),
              const SizedBox(height: AppSpacing.xl),
              _ProgressSection(
                currentPoints: card.currentPoints,
                targetPoints: card.targetPoints,
              ),
              const SizedBox(height: AppSpacing.xl),
              _RewardSection(
                isUnlocked: isUnlocked,
                remainingPoints: remainingPoints,
              ),
              const SizedBox(height: AppSpacing.xl),
              const _TermsSection(),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (_) => MemberCodeScreen(card: card),
                        ),
                    );
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                  ),
                  child: Text(
                    isUnlocked ? 'Redeem reward' : 'Show member code',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  final RewardCardModel card;

  const _DetailTopBar({required this.card});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconButtonBox(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
        const Spacer(),
        Text(
          card.merchantName,
          style: AppTextStyles.title,
        ),
        const Spacer(),
        const _IconButtonBox(
          icon: Icons.more_horiz_rounded,
        ),
      ],
    );
  }
}

class _IconButtonBox extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButtonBox({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: Ink(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Icon(
          icon,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final int currentPoints;
  final int targetPoints;

  const _ProgressSection({
    required this.currentPoints,
    required this.targetPoints,
  });

  @override
  Widget build(BuildContext context) {
    final progressRatio = currentPoints / targetPoints;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Progress', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$currentPoints of $targetPoints collected',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: progressRatio,
              minHeight: 12,
              backgroundColor: AppColors.surfaceSoft,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: List.generate(
              targetPoints,
              (index) {
                final isCompleted = index < currentPoints;
                return Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primary
                        : AppColors.surfaceSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_rounded : Icons.circle_outlined,
                    size: 16,
                    color: isCompleted
                        ? Colors.white
                        : AppColors.textMuted,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardSection extends StatelessWidget {
  final bool isUnlocked;
  final int remainingPoints;

  const _RewardSection({
    required this.isUnlocked,
    required this.remainingPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: isUnlocked ? const Color(0xFFEFFCF3) : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: isUnlocked ? const Color(0xFFBBF7D0) : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? AppColors.success.withValues(alpha: 0.14)
                      : AppColors.warning.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  isUnlocked
                      ? Icons.celebration_rounded
                      : Icons.card_giftcard_rounded,
                  color: isUnlocked ? AppColors.success : AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isUnlocked ? 'Reward unlocked' : 'Upcoming reward',
                      style: AppTextStyles.title,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text(
                      'Free handcrafted drink',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            isUnlocked
                ? 'You can now redeem your reward at checkout.'
                : 'Collect $remainingPoints more ${remainingPoints == 1 ? 'visit' : 'visits'} to unlock this reward.',
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Program details', style: AppTextStyles.title),
          SizedBox(height: AppSpacing.md),
          Text(
            '• One point is collected per eligible purchase.\n'
            '• Rewards can only be redeemed in-store.\n'
            '• Points reset after redemption.\n'
            '• This demo app uses mock data only.',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}