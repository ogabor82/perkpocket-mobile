import 'package:flutter/material.dart';
import '../models/reward_card_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class MemberCodeScreen extends StatelessWidget {
  final RewardCardModel card;

  const MemberCodeScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final memberCode = 'PP-${card.id.padLeft(4, '0')}-2026';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(card: card),
              const SizedBox(height: AppSpacing.xl),
              _MerchantHeader(card: card),
              const SizedBox(height: AppSpacing.xl),
              _CodeCard(memberCode: memberCode),
              const SizedBox(height: AppSpacing.xl),
              const _InstructionsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final RewardCardModel card;

  const _TopBar({required this.card});

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
          'Member code',
          style: AppTextStyles.title,
        ),
        const Spacer(),
        const _IconButtonBox(
          icon: Icons.ios_share_rounded,
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

class _MerchantHeader extends StatelessWidget {
  final RewardCardModel card;

  const _MerchantHeader({required this.card});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: card.backgroundColor.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Icon(
            card.icon,
            color: card.backgroundColor,
            size: 28,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(card.merchantName, style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.xs),
              Text(card.programName, style: AppTextStyles.bodySecondary),
            ],
          ),
        ),
      ],
    );
  }
}

class _CodeCard extends StatelessWidget {
  final String memberCode;

  const _CodeCard({required this.memberCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Show this code at checkout',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'The merchant can scan or enter your member code to add points.',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              children: [
                const _BarcodePlaceholder(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  memberCode,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColors.textPrimary,
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

class _BarcodePlaceholder extends StatelessWidget {
  const _BarcodePlaceholder();

  @override
  Widget build(BuildContext context) {
    final bars = List.generate(
      36,
      (index) => (index % 4 == 0 || index % 5 == 0) ? 4.0 : 2.0,
    );

    return SizedBox(
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: bars.map((width) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _InstructionsCard extends StatelessWidget {
  const _InstructionsCard();

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
          Text('How it works', style: AppTextStyles.title),
          SizedBox(height: AppSpacing.md),
          Text(
            '• Present this screen during checkout.\n'
            '• The merchant can identify your membership.\n'
            '• Points are added after eligible purchases.\n'
            '• Rewards can be redeemed once unlocked.',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}