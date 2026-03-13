import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../models/saved_card_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../theme/color_utils.dart';

class SavedCardDetailScreen extends StatelessWidget {
  final SavedCardModel card;

  const SavedCardDetailScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final brandColor = ColorUtils.fromHex(card.brandHex);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(card: card),
              const SizedBox(height: AppSpacing.xl),
              _MerchantHeader(card: card, brandColor: brandColor),
              const SizedBox(height: AppSpacing.xl),
              _BarcodeCard(card: card),
              const SizedBox(height: AppSpacing.xl),
              _MetaInfoCard(card: card),
              const SizedBox(height: AppSpacing.xl),
              const _UsageNotesCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final SavedCardModel card;

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

class _MerchantHeader extends StatelessWidget {
  final SavedCardModel card;
  final Color brandColor;

  const _MerchantHeader({
    required this.card,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: brandColor.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Icon(
            Icons.credit_card_rounded,
            color: brandColor,
            size: 30,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(card.merchantName, style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.xs),
              Text(card.label, style: AppTextStyles.bodySecondary),
            ],
          ),
        ),
      ],
    );
  }
}

class _BarcodeCard extends StatelessWidget {
  final SavedCardModel card;

  const _BarcodeCard({required this.card});

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
            'Present this card at checkout',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Type: ${card.codeType.toUpperCase()}',
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
                _RealBarcodeWidget(card: card),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  card.codeValue,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RealBarcodeWidget extends StatelessWidget {
  final SavedCardModel card;

  const _RealBarcodeWidget({
    required this.card,
  });

  Barcode _resolveBarcodeType() {
    switch (card.codeType.toLowerCase()) {
      case 'ean13':
        return Barcode.ean13();
      case 'ean8':
        return Barcode.ean8();
      case 'code128':
        return Barcode.code128();
      case 'qr':
        return Barcode.qrCode();
      default:
        return Barcode.code128();
    }
  }

  @override
  Widget build(BuildContext context) {
    final barcode = _resolveBarcodeType();
    final isQr = card.codeType.toLowerCase() == 'qr';

    return BarcodeWidget(
      barcode: barcode,
      data: card.codeValue,
      width: double.infinity,
      height: isQr ? 180 : 100,
      drawText: false,
      color: AppColors.textPrimary,
      backgroundColor: Colors.transparent,
      errorBuilder: (context, error) {
        return Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            'Unsupported barcode data',
            style: AppTextStyles.bodySecondary,
          ),
        );
      },
    );
  }
}
class _MetaInfoCard extends StatelessWidget {
  final SavedCardModel card;

  const _MetaInfoCard({required this.card});

  @override
  Widget build(BuildContext context) {
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
          const Text('Card details', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.lg),
          _MetaRow(
            label: 'Merchant',
            value: card.merchantName,
          ),
          const SizedBox(height: AppSpacing.md),
          _MetaRow(
            label: 'Label',
            value: card.label,
          ),
          const SizedBox(height: AppSpacing.md),
          _MetaRow(
            label: 'Code type',
            value: card.codeType.toUpperCase(),
          ),
          const SizedBox(height: AppSpacing.md),
          _MetaRow(
            label: 'Last digits',
            value: card.lastDigits,
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySecondary,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _UsageNotesCard extends StatelessWidget {
  const _UsageNotesCard();

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
          Text('Notes', style: AppTextStyles.title),
          SizedBox(height: AppSpacing.md),
          Text(
            '• Show this screen when using the card in-store.\n'
            '• This is currently a demo representation of the saved code.\n'
            '• In a later step, the barcode renderer and scanner can be connected to this flow.',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}