import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsWidget extends StatefulWidget {
  final String text;
  const TtsWidget({super.key, required this.text});
  @override
  // ignore: library_private_types_in_public_api
  _TtsWidgetState createState() => _TtsWidgetState();
}

class _TtsWidgetState extends State<TtsWidget> {
  final FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false; // To track whether the TTS is on or off

  @override
  void initState() {
    super.initState();
    _init(); // Initialize the TTS
  }

  void _init() async {
    await flutterTts.setPitch(1.0); // Optional: Adjust pitch
    await flutterTts.setSpeechRate(0.5); // Optional: Adjust speech rate
  }

  void _toggleSpeech() async {
    if (_isSpeaking) {
      await flutterTts.stop(); // Stop speaking if already speaking
    } else {
      await flutterTts.speak(widget.text); // Nepali text
    }

    setState(() {
      _isSpeaking = !_isSpeaking; // Toggle the speaking state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSpeech,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: _isSpeaking
                ? Colors.grey[700]
                : Colors.grey, // Change color based on state
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _isSpeaking
                ? Icons.volume_off
                : Icons.volume_up, // Change icon based on state
            size: 21,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
