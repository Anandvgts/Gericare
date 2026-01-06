import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gericare_doctor/core/res/styles.dart';


class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// CAMERA
          MobileScanner(
            onDetect: (barcode) {
              final String? code = barcode.barcodes.first.rawValue;
              if (code == null) return;

              Navigator.pop(context, code); // return scanned data
            },
          ),

          /// SCAN FRAME
          Center(
            child: Container(
              width: 280,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),

          /// BOTTOM INFO
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: Column(
              children: [
                Text(
                  "Scan QR Code",
                  style: AppTextStyle.title1Bold.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Scan the QR code to access Mr. Krishna\nKumar daily routine and task list.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyText2SubText.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ward A - 104 A",
                  style: AppTextStyle.bodyText2Bold.copyWith(
                    color: Colors.white,
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
