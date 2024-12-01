import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:late_blight/api/api.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/chat.dart';
import 'package:late_blight/screen/login/login_bloc.dart';
import 'package:path_provider/path_provider.dart';

class RenderAudioHandler extends StatefulWidget {
  final ChatModel chat;
  const RenderAudioHandler({super.key, required this.chat});

  @override
  State<RenderAudioHandler> createState() => _RenderAudioHandlerState();
}

class _RenderAudioHandlerState extends State<RenderAudioHandler> {
  final _audioPlayer = AudioPlayer();
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
  ValueNotifier<File?> snapshot = ValueNotifier(null);
  ValueNotifier<double> aspectRatio = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    _audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _isPlaying.value = false;
      }
      if (event.processingState == ProcessingState.idle) {
        _isPlaying.value = false;
      }
    });
  }

  Future<String> _saveAudioToTempFile(Uint8List audioBytes) async {
    final directory = await getTemporaryDirectory();
    final file =
        await File('${directory.path}/saved_sound.wav').create(recursive: true);
    await file.writeAsBytes(audioBytes);
    return file.path;
  }

  Future<void> playAudioFromBase64(String base64Audio) async {
    bool isNetworkAudio() {
      final RegExp regExp = RegExp(r'media|audio|https?://');
      return regExp.hasMatch(base64Audio);
    }

    if (base64Audio.isNotEmpty) {
      try {
        if (isNetworkAudio()) {
          final user = context.read<LoginBloc>().state.loggedInUser;
          final url =
              "${Config.chatApiUrl}$base64Audio?chatId=${widget.chat.chatId}";
          //download the audio file
          final response = await API.getWithFullUrl(
            url,
            headers: {
              'Authorization': user == null ? "" : user.accessToken!,
            },
            responseType: ResponseType.bytes,
          );
          if (response.statusCode == 200) {
            final bytes = response.data;
            final path = await _saveAudioToTempFile(bytes);
            await _audioPlayer.setAudioSource(
              AudioSource.file(path),
              preload: true,
            );
          }
        } else {
          final baseString = base64Audio;
          final bytes = base64Decode(baseString);
          final path = await _saveAudioToTempFile(bytes);
          await _audioPlayer.setAudioSource(
            AudioSource.file(path),
            preload: true,
          );
        }

        _audioPlayer.play();
        _isPlaying.value = true;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    //release the audio player
    _audioPlayer.dispose();

    //dispose the value notifier
    _isPlaying.dispose();
    snapshot.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget handleAudio(ChatModel chat) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder<bool>(
                valueListenable: _isPlaying,
                builder: (context, isPlaying, child) {
                  return Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  );
                },
              ),
              onPressed: () {
                if (_isPlaying.value) {
                  _audioPlayer.pause();
                  _isPlaying.value = false;
                } else {
                  playAudioFromBase64(chat.message);
                }
              },
            ),
            Icon(
              Icons.multitrack_audio_outlined,
              color: Colors.white,
              size: 36,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      );
    }

    return handleAudio(widget.chat);
  }
}
