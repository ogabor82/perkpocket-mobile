import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TopBar(),
              const SizedBox(height: AppSpacing.xl),
              const _WelcomeSection(),
              const SizedBox(height: AppSpacing.xl),
              const _SearchField(),
              const SizedBox(height: AppSpacing.xl),
              const _SectionHeader(
                title: 'My reward cards',
                actionLabel: 'See all',
              ),
              const SizedBox(height: AppSpacing.lg),
              _CardListPlaceholder(),
              const SizedBox(height: AppSpacing.xl),
              const _SectionHeader(
                title: 'Featured offers',
                actionLabel: 'Explore',
              ),
              const SizedBox(height: AppSpacing.lg),
              const _OfferPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const Icon(
            Icons.menu_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello, Gábor!', style: AppTextStyles.hero),
        SizedBox(height: AppSpacing.sm),
        Text(
          'Collect perks and rewards from your favorite places.',
          style: AppTextStyles.bodySecondary,
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: AppColors.textSecondary),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Search merchants or rewards',
              style: AppTextStyles.bodySecondary,
            ),
          ),
          Icon(Icons.tune_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.title),
        const Spacer(),
        Text(
          actionLabel,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}

class _CardListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          return Container(
            width: 260,
            decoration: BoxDecoration(
              color: index == 0
                  ? AppColors.cardRed
                  : index == 1
                      ? AppColors.cardBlue
                      : AppColors.cardGold,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.card_giftcard, color: Colors.white),
                ),
                const Spacer(),
                const Text(
                  'Demo Rewards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${index + 2}/10 collected',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OfferPlaceholder extends StatelessWidget {
  const _OfferPlaceholder();

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
          Text('Free coffee after 10 visits', style: AppTextStyles.title),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Discover nearby merchants with simple digital reward cards.',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}