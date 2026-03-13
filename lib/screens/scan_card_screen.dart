import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'manual_add_card_screen.dart';

class ScanCardScreen extends StatefulWidget {
  const ScanCardScreen({super.key});

  @override
  State<ScanCardScreen> createState() => _ScanCardScreenState();
}

class _ScanCardScreenState extends State<ScanCardScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.code128,
      BarcodeFormat.qrCode,
    ],
  );

  bool _hasHandledDetection = false;
  bool _isTorchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _mapBarcodeFormat(BarcodeFormat format) {
    switch (format) {
      case BarcodeFormat.ean13:
        return 'ean13';
      case BarcodeFormat.ean8:
        return 'ean8';
      case BarcodeFormat.code128:
        return 'code128';
      case BarcodeFormat.qrCode:
        return 'qr';
      default:
        return null;
    }
  }

Future<void> _handleDetection(BarcodeCapture capture) async {
  if (_hasHandledDetection) return;

  Barcode? barcode;
  for (final item in capture.barcodes) {
    if (item.rawValue != null) {
      barcode = item;
      break;
    }
  }

  if (barcode == null) return;

  final rawValue = barcode.rawValue?.trim();
  if (rawValue == null || rawValue.isEmpty) return;

  _hasHandledDetection = true;

  await _controller.stop();

  if (!mounted) return;

  final mappedType = _mapBarcodeFormat(barcode.format) ?? 'code128';

  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => ManualAddCardScreen(
        initialCodeValue: rawValue,
        initialCodeType: mappedType,
      ),
    ),
  );

  if (!mounted) return;

  _hasHandledDetection = false;
  await _controller.start();
}

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();

    if (!mounted) return;

    setState(() {
      _isTorchOn = !_isTorchOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleDetection,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Row(
                    children: [
                      _CircleActionButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      _CircleActionButton(
                        icon: _isTorchOn
                            ? Icons.flash_on_rounded
                            : Icons.flash_off_rounded,
                        onTap: _toggleTorch,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const _ScannerOverlayCard(),
                  const Spacer(),
                  const Text(
                    'Align the barcode or QR code within the frame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'Supported: EAN13, EAN8, Code128, QR',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      onTap: onTap,
      child: Ink(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ScannerOverlayCard extends StatelessWidget {
  const _ScannerOverlayCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Scan your card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          width: 280,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                top: 16,
                left: 16,
                child: _CornerMark(top: true, left: true),
              ),
              const Positioned(
                top: 16,
                right: 16,
                child: _CornerMark(top: true, left: false),
              ),
              const Positioned(
                bottom: 16,
                left: 16,
                child: _CornerMark(top: false, left: true),
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                child: _CornerMark(top: false, left: false),
              ),
              Center(
                child: Container(
                  width: 220,
                  height: 2,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CornerMark extends StatelessWidget {
  final bool top;
  final bool left;

  const _CornerMark({
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _CornerPainter(top: top, left: left),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool top;
  final bool left;

  _CornerPainter({
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (top && left) {
      path
        ..moveTo(size.width, 0)
        ..lineTo(0, 0)
        ..lineTo(0, size.height);
    } else if (top && !left) {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height);
    } else if (!top && left) {
      path
        ..moveTo(0, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height);
    } else {
      path
        ..moveTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}