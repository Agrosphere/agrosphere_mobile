import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceRecorder {
  final audio = AudioRecorder();
  Future<Stream<Uint8List>?> startRecorder() async {
    if (!await audio.hasPermission()) {
      await Permission.microphone.request();
    } else {
      final stream = await audio.startStream(
        const RecordConfig(
          androidConfig: AndroidRecordConfig(),
          encoder: AudioEncoder.pcm16bits,
          bitRate: 16000,
          sampleRate: 16000,
        ),
      );
      return stream;
    }
    return null;
  }

  Future<File?> startRecorderWithFile() async {
    if (!await audio.hasPermission()) {
      await Permission.microphone.request();
    } else {
      final appDir = await getTemporaryDirectory();
      final filePath = '${appDir.path}/voice_recorder.wav';
      await audio.start(
        const RecordConfig(
          androidConfig: AndroidRecordConfig(),
          encoder: AudioEncoder.wav,
          bitRate: 16000,
          sampleRate: 16000,
        ),
        path: filePath,
      );
      return File(filePath);
    }
    return null;
  }

  Future<String?> stopRecorder() async {
    return await audio.stop();
  }

  void dispose() async {
    await audio.dispose();
  }
}
