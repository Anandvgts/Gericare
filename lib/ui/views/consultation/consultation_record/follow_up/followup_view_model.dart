import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';

class UploadedFile {
  final String name;
  final File file;

  UploadedFile({required this.name, required this.file});
}

class FollowUpNotesViewModel extends VGTSBaseViewModel {
  /// Controllers
  final TextEditingController prescriptionNotesCtrl =
      TextEditingController();
  final TextEditingController doctorNotesCtrl = TextEditingController();

  /// Dropdown values
  DateTime? followUpDate;
  String? referral;

  /// Upload
  final List<UploadedFile> files = [];
  String? uploadError;

  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  /// Pick File
  Future<void> pickFile() async {
    uploadError = null;
    notifyListeners();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result == null) return;

    final file = File(result.files.single.path!);
    final size = await file.length();

    if (size > maxFileSize) {
      uploadError = "File size should not exceed 5 MB";
      notifyListeners();
      return;
    }

    files.add(
      UploadedFile(
        name: result.files.single.name,
        file: file,
      ),
    );

    notifyListeners();
  }

  void removeFile(UploadedFile file) {
    files.remove(file);
    notifyListeners();
  }

  void submit() {
    // API call or navigation
    debugPrint("Consultation closed");
  }
}
