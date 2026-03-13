import 'package:flutter/material.dart';
import '../data/mock_cards.dart';
import '../data/mock_saved_cards.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/reward_card.dart';
import '../widgets/saved_card_list_item.dart';
import 'home_screen.dart';
import 'add_card_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    const HomeScreen(),
    const _WalletScreen(),
    const _ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primary.withValues(alpha: 0.12),
        height: 76,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet_outlined),
            selectedIcon: Icon(Icons.wallet_rounded),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _WalletScreen extends StatelessWidget {
  const _WalletScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const Text('My Wallet', style: AppTextStyles.h1),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Keep both your digital reward programs and saved external cards in one place.',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSpacing.xl),

              const _WalletSectionHeader(
                title: 'Quick access rewards',
                actionLabel: 'See all',
              ),
              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                height: 190,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mockCards.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.lg),
                  itemBuilder: (context, index) {
                    return RewardCard(card: mockCards[index]);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              const _AddCardCallout(),

              const SizedBox(height: AppSpacing.xl),

              const _WalletSectionHeader(
                title: 'Saved external cards',
                actionLabel: 'Manage',
              ),
              const SizedBox(height: AppSpacing.lg),

              ListView.separated(
                itemCount: mockSavedCards.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.lg),
                itemBuilder: (context, index) {
                  final card = mockSavedCards[index];
                  return SavedCardListItem(card: card);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: AppSpacing.md),
              Text('Profile', style: AppTextStyles.h1),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Account, preferences and membership settings.',
                style: AppTextStyles.bodySecondary,
              ),
              SizedBox(height: AppSpacing.xl),
              _PlaceholderBlock(
                title: 'Profile screen coming next',
                subtitle:
                    'Later we can add account details, settings and notification preferences.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderBlock extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PlaceholderBlock({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle, style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
}

class _WalletSectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;

  const _WalletSectionHeader({
    required this.title,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.title),
        const Spacer(),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddCardCallout extends StatelessWidget {
  const _AddCardCallout();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddCardScreen(),
          ),
        );
      },
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add_card_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a new card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Scan or add an external loyalty card manually.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}