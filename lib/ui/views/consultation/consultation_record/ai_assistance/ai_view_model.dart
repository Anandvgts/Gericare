import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:record/record.dart';
import 'package:stacked/stacked.dart';

enum AIRecordState { idle, recording, recorded }

class AIAssistanceViewModel extends BaseViewModel {
  final AudioRecorder _recorder = AudioRecorder();

  AIRecordState state = AIRecordState.idle;

  Timer? _timer;
  int _seconds = 0;

  String? audioPath;

  String get timerText {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  /// -------- START RECORDING --------
  Future<void> startRecording() async {
    if (!await _recorder.hasPermission()) return;

    final dir = await getApplicationDocumentsDirectory();
    audioPath =
        "${dir.path}/ai_record_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: audioPath!,
    );

    _seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;
      notifyListeners();
    });

    state = AIRecordState.recording;
    notifyListeners();
  }

  /// -------- STOP RECORDING --------
  Future<void> stopRecording() async {
    await _recorder.stop();
    _timer?.cancel();

    state = AIRecordState.recorded;
    notifyListeners();
  }

  /// -------- PROCESS (DOWNLOAD) --------
  // Future<File?> processRecording() async {
  //   if (audioPath == null) return null;

  //   final file = File(audioPath!);
  //   return file.existsSync() ? file : null;
  // }

  Future<File?> processRecording() async {
    if (audioPath == null) return null;

    final sourceFile = File(audioPath!);
    if (!sourceFile.existsSync()) return null;

    /// Request storage permission
    final permissionStatus = await _requestStoragePermission();
    if (!permissionStatus) {
      print('Storage permission denied');
      return null;
    }

    /// Get public directory path
    final Directory publicDir = await _getPublicDirectory();

    /// Create custom folder: GeriCare/Consultations
    final Directory consultDir =
        Directory(p.join(publicDir.path, 'GeriCare', 'Consultations'));

    if (!await consultDir.exists()) {
      await consultDir.create(recursive: true);
    }

    /// Generate unique file name with readable timestamp
    final now = DateTime.now();
    final String fileName =
        'consult_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}.m4a';

    final String newPath = p.join(consultDir.path, fileName);
    print('Saving to: $newPath');

    /// Copy file to public location
    final File savedFile = await sourceFile.copy(newPath);

    /// Scan file to make it visible in gallery/file managers immediately
    await _scanFile(newPath);

    print('File saved and accessible at: $newPath');
    return savedFile;
  }

// Request storage permission based on Android version
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      // Android 13+ (API 33+) - No storage permission needed for app-specific directories
      if (androidInfo.version.sdkInt >= 33) {
        return true;
      }
      // Android 10-12 (API 29-32)
      else if (androidInfo.version.sdkInt >= 29) {
        return await Permission.storage.request().isGranted;
      }
      // Android 9 and below (API 28-)
      else {
        return await Permission.storage.request().isGranted;
      }
    }
    return true; // iOS doesn't need storage permission
  }

  /// Get public directory based on Android version
  Future<Directory> _getPublicDirectory() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      // For Android 10+ (Scoped Storage)
      if (androidInfo.version.sdkInt >= 29) {
        // Use Music directory (accessible via file manager)
        return Directory('/storage/emulated/0/Music');

        // Alternative: Use Downloads directory
        // return Directory('/storage/emulated/0/Download');
      } else {
        // For older Android versions
        final directory = await getExternalStorageDirectory();
        return Directory('/storage/emulated/0/Music');
      }
    } else {
      // iOS - Use documents directory
      return await getApplicationDocumentsDirectory();
    }
  }

  /// Scan file to make it visible in media scanner (Android only)
  Future<void> _scanFile(String filePath) async {
    if (Platform.isAndroid) {
      try {
        // This makes the file visible in file managers immediately
        final result = await Process.run('am', [
          'broadcast',
          '-a',
          'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
          '-d',
          'file://$filePath'
        ]);
        print('Media scan result: ${result.stdout}');
      } catch (e) {
        print('Media scan error: $e');
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }
}
