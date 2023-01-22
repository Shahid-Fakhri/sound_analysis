// ignore_for_file: avoid_print, unused_local_variable
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import './audio_waveform.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorder({Key key, this.onStop}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  int _recordDuration = 0;
  Timer _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState> _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude> _amplitudeSub;
  Amplitude _amplitude;

  @override
  void initState() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 200))
        .listen((amp) => setState(() {
              _amplitude = amp;
            }));

    super.initState();
  }

  Future<void> _start() async {
    print('recording start');
    try {
      if (await _audioRecorder.hasPermission()) {
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }
        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error after TRY: $e');
      }
    }
  }

  Future<void> _stop() async {
    print('recording stops');
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      widget.onStop(path);
    }
  }

  Future<void> _pause() async {
    print('recording pause');
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    print('recording resume');
    _startTimer();
    await _audioRecorder.resume();
  }

  @override
  Widget build(BuildContext context) {
    print('Build running again');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_amplitude != null) ...[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 150, horizontal: 2),
                height: 200,
                width: double.infinity,
                color: Colors.black,
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: AudioWaveForm(
                      amplitude: (_amplitude != null) &&
                              (_amplitude.current != double.infinity) &&
                              (_amplitude.current != double.negativeInfinity)
                          ? _amplitude.current.roundToDouble()
                          : 0.0),
                ),
              ),
            ],
            Column(
              children: [
                _buildText(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildRecordStopControl(),
                    const SizedBox(width: 20),
                    _buildPauseResumeControl(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    Icon icon;
    Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.mic, color: Colors.white, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ElevatedButton.icon(
      onPressed: () {
        (_recordState != RecordState.stop) ? _stop() : _start();
      },
      icon: icon,
      label: Text(_recordState != RecordState.stop ? 'STOP' : 'START'),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    Icon icon;
    Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.white, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.white, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ElevatedButton.icon(
      onPressed: () {
        (_recordState == RecordState.pause) ? _resume() : _pause();
      },
      icon: icon,
      label: Text(_recordState != RecordState.record ? 'PLAY' : 'PAUSE'),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }
    return const SizedBox.shrink();
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}
