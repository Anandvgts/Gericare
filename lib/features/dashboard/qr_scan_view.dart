import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/core/styles/text_styles.dart';

class QrScanView extends StatelessWidget {
  const QrScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 🔹 LIVE BACK CAMERA
          Positioned.fill(
            child: MobileScanner(
              controller: MobileScannerController(
                facing: CameraFacing.back,
                detectionSpeed: DetectionSpeed.noDuplicates,
              ),
              onDetect: (barcode) {
                final value = barcode.barcodes.first.rawValue;
                if (value != null) {
                  debugPrint("QR Code: $value");

                  // TODO:
                  // navigationService.replaceWith(
                  //   Routes.consultation,
                  //   arguments: value,
                  // );
                }
              },
            ),
          ),

          /// 🔹 DARK OVERLAY
          Positioned.fill(
            child: _OverlayWithCutout(),
          ),

          /// 🔹 SCAN FRAME
          Align(
            alignment: const Alignment(0, -0.1),
            child: _ScanFrame(),
          ),

          /// 🔹 BOTTOM TEXT (NO CARD)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Scan QR Code",
                    style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 250.w,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyle.bodyText2SubText.copyWith(
                          color: Colors.white,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text: "Scan the QR code to access ",
                          ),
                          TextSpan(
                            text: "Mr. Krishna Kumar",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: " daily routine and task list.",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Ward A - 104 A",
                    style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 14.h,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlayWithCutout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OverlayPainter(),
      child: Container(),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // Calculate scan frame position (same as _ScanFrame)
    final scanWidth = 280.0.w;
    final scanHeight = 160.0.h;
    final scanLeft = (size.width - scanWidth) / 2;
    // Alignment(0, -0.1) means slightly above center
    final centerY = size.height / 2;
    final offsetY = size.height * -0.1; // -0.1 from Alignment(0, -0.1)
    final scanTop = centerY + offsetY - (scanHeight / 5);
    final scanRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scanLeft, scanTop, scanWidth, scanHeight),
      Radius.circular(12.r),
    );

    // Create path with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(scanRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScanFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 160.h,
      child: Stack(
        children: [
          _corner(Alignment.topLeft),
          _corner(Alignment.topRight),
          _corner(Alignment.bottomLeft),
          _corner(Alignment.bottomRight),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 40.w,
              height: 3,
              color: Colors.white,
            ),
          ),

          /// BOTTOM CENTER LINE
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 2.h),
              width: 40.w,
              height: 3,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _corner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y == -1 ? _border() : BorderSide.none,
            left: alignment.x == -1 ? _border() : BorderSide.none,
            right: alignment.x == 1 ? _border() : BorderSide.none,
            bottom: alignment.y == 1 ? _border() : BorderSide.none,
          ),
        ),
      ),
    );
  }

  BorderSide _border() => const BorderSide(color: Colors.white, width: 3);
}
