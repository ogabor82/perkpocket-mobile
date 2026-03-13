import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class ManualAddCardScreen extends StatefulWidget {
  const ManualAddCardScreen({super.key});

  @override
  State<ManualAddCardScreen> createState() => _ManualAddCardScreenState();
}

class _ManualAddCardScreenState extends State<ManualAddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final _merchantController = TextEditingController();
  final _labelController = TextEditingController();
  final _codeValueController = TextEditingController();

  String _selectedCodeType = 'ean13';

  final List<String> _codeTypes = const [
    'ean13',
    'code128',
    'qr',
    'ean8',
  ];

  @override
  void dispose() {
    _merchantController.dispose();
    _labelController.dispose();
    _codeValueController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manual card saving will be wired up in the next step.'),
      ),
    );
  }

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
              const Text(
                'Add card manually',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Enter the card details below so you can access it later from your wallet.',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _FieldLabel('Merchant name'),
                      const SizedBox(height: AppSpacing.sm),
                      _AppTextField(
                        controller: _merchantController,
                        hintText: 'e.g. COOP',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a merchant name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const _FieldLabel('Card label'),
                      const SizedBox(height: AppSpacing.sm),
                      _AppTextField(
                        controller: _labelController,
                        hintText: 'e.g. Main grocery card',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a card label';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const _FieldLabel('Code value'),
                      const SizedBox(height: AppSpacing.sm),
                      _AppTextField(
                        controller: _codeValueController,
                        hintText: 'e.g. 5991234567890',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the code value';
                          }
                          if (value.trim().length < 4) {
                            return 'Code value looks too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const _FieldLabel('Code type'),
                      const SizedBox(height: AppSpacing.sm),
                      _CodeTypeDropdown(
                        value: _selectedCodeType,
                        items: _codeTypes,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCodeType = value;
                          });
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveCard,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textPrimary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.lg,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.xl),
                            ),
                          ),
                          child: const Text(
                            'Save card',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                    ],
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

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconButtonBox(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
        const Spacer(),
        const Text(
          'Manual entry',
          style: AppTextStyles.title,
        ),
        const Spacer(),
        const SizedBox(width: 44),
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

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const _AppTextField({
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 15,
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _CodeTypeDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _CodeTypeDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item.toUpperCase()),
        );
      }).toList(),
    );
  }
}