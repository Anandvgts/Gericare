import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// class PdfViewerView extends StatelessWidget {
//   final String filePath; // local PDF path
//   final String title;
//   final String date;

//   const PdfViewerView(
//       {super.key,
//       required this.filePath,
//       required this.title,
//       required this.date});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(
//         title: "Report",
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Container(
//             color: Colors.white,
//             child: PDFView(
//               filePath: filePath,
//               enableSwipe: true,
//               swipeHorizontal: false,
//               autoSpacing: true,
//               pageSnap: true,
//               fitPolicy: FitPolicy.BOTH,
//               onError: (error) {
//                 debugPrint(error.toString());
//               },
//               onPageError: (page, error) {
//                 debugPrint('$page: ${error.toString()}');
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

Future<String> loadPdfFromAssets(String assetPath) async {
  final bytes = await rootBundle.load(assetPath);
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/${assetPath.split('/').last}');
  await file.writeAsBytes(bytes.buffer.asUint8List());
  return file.path;
}

class PdfViewerView extends StatefulWidget {
  final String filePath;
  final String title;
  final String date;

  const PdfViewerView({
    super.key,
    required this.filePath,
    required this.title,
    required this.date,
  });

  @override
  State<PdfViewerView> createState() => _PdfViewerViewState();
}

class _PdfViewerViewState extends State<PdfViewerView> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final path = widget.filePath.startsWith('assets/')
        ? await loadPdfFromAssets(widget.filePath)
        : widget.filePath;

    setState(() {
      localPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBarWidget(
        title: 'Mr.Krishna Kumar’s Prescription',
        subtitle: DateTime.now().toIso8601String(),
      ),
      body: localPath == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  autoSpacing: true,
                  pageSnap: true,
                  fitPolicy: FitPolicy.BOTH,
                ),
              ),
            ),
    );
  }
}
