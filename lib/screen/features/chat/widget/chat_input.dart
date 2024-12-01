import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:late_blight/model/chat.dart';
import 'package:late_blight/screen/features/chat/page/recoder.dart';
import 'package:late_blight/screen/features/chat_ai/bloc/ai_chatbloc.dart';
import 'package:late_blight/services/image_handler.dart';
import 'package:late_blight/widgets/text_field.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatInputField extends StatefulWidget {
  final WebSocketChannel? channel;
  final Function()? onSend;
  final ChatModel? replayTo;
  const ChatInputField({super.key, this.channel, this.onSend, this.replayTo});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final _voiceRecorder = VoiceRecorder();
  final ValueNotifier<bool> _isRecording = ValueNotifier(false);
  final ValueNotifier<List<Uint8List>> audioRecord = ValueNotifier([]);
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isSendChatButtonEnabled = ValueNotifier(false);
  final ValueNotifier<ChatModel?> replayTo = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
  }

  void recordVoice() async {
    sendInteraction("Recording voice...");
    await _voiceRecorder.startRecorderWithFile();
  }

  void stopRecord() async {
    final currentFile = await _voiceRecorder.stopRecorder();
    final file = File(currentFile!);
    if (!await file.exists()) {
      debugPrint("File not found");
      return;
    }
    final audio = file.readAsBytesSync();
    final base64 = base64Encode(audio.toList());
    final body = {
      "message": base64,
      "type": "audio",
    };
    handleOnSend(body);
  }

  void sendInteraction(String interaction) {
    final json = jsonEncode({
      "interact": interaction,
    });
    widget.channel!.sink.add(json);
  }

  void sendChat(String message) {
    if (message.isEmpty) return;
    final body = {
      "message": message,
      "type": "text",
      "parentId": widget.replayTo?.chatId,
    };
    handleOnSend(body);
    _controller.clear();
    // _focusNode.unfocus();
    _isSendChatButtonEnabled.value = false;
  }

  void pickImage() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        final file = File(value.path);
        final base64 = base64Encode(await compressImage(file, quality: 25));
        final body = {
          "message": base64,
          "type": "image",
        };
        sendInteraction("Sending image...");
        handleOnSend(body);
      }
    });
  }

  void handleOnSend(Map<String, dynamic>? body) {
    widget.channel!.sink.add(jsonEncode(body));
    if (widget.onSend != null) widget.onSend!();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputField() {
      return BlocBuilder<AiChatbloc, AiChatModel>(
        builder: (context, state) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: 66,
            ),
            child: Row(
              children: [
                Expanded(
                  child: KrishiTextField(
                    focusNode: _focusNode,
                    boxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    maxLength: 100,
                    radius: 24,
                    onClickImage: () {
                      pickImage();
                    },
                    maxLines: null,
                    hasImagePicker: true,
                    controller: _controller,
                    textInputAction: TextInputAction.newline,
                    hintText: "Send a message",
                    onChanged: (p0) {
                      if (p0.toString().trim().isNotEmpty) {
                        sendInteraction("Typing...");
                      } else {
                        debugPrint("Empty message");
                        sendInteraction(" ");
                      }
                      _isSendChatButtonEnabled.value = p0.isNotEmpty;
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isSendChatButtonEnabled,
                  builder: (context, value, child) {
                    if (value) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                sendChat(_controller.text);
                              },
                              icon: const Icon(Icons.send),
                            ),
                          ),
                        ),
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (_isRecording.value) {
                                  stopRecord();
                                } else {
                                  recordVoice();
                                }
                                _isRecording.value = !_isRecording.value;
                              },
                              icon: Transform.rotate(
                                angle: 0,
                                child: ValueListenableBuilder(
                                  valueListenable: _isRecording,
                                  builder: (context, value, child) {
                                    return value
                                        ? const Icon(
                                            Icons.stop,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.mic,
                                            color: Colors.white,
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return inputField();
  }
}
