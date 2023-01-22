// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './audio_player.dart';
import './audio_recorder.dart';

class SoundRecorderScreen extends StatefulWidget {
  static const routeName = '/sound-recorder';

  SoundRecorderScreen({Key key}) : super(key: key);

  @override
  State<SoundRecorderScreen> createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  bool showPlayer = false;
  String audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building main: showPlayer status: $showPlayer');
    return MaterialApp(
      title: 'Audio Recorder',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Recording'),
        ),
        body: SafeArea(
          child: Center(
            child: showPlayer
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AudioPlayer(
                      source: audioPath,
                      onDelete: () {
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
        ),
      ),
    );
  }
}
