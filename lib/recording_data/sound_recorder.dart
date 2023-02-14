import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './audio_player.dart';
import './audio_recorder.dart';
import '../services/database.dart';

class SoundRecorderScreen extends StatefulWidget {
  static const routeName = '/sound-recorder';
  const SoundRecorderScreen({Key key}) : super(key: key);

  @override
  State<SoundRecorderScreen> createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  bool showPlayer = false;
  String audioPath;
  String id;
  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recording'),
      ),
      body: SafeArea(
        child: showPlayer
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AudioPlayer(
                  id,
                  audioPath,
                  () {
                    setState(() => showPlayer = false);
                  },
                ),
              )
            : AudioRecorder(
                onStop: (path) {
                  if (kDebugMode) print('Recorded file path: $path');
                  setState(() {
                    audioPath = path;
                    showPlayer = true;
                  });
                },
              ),
      ),
    );
  }
}
