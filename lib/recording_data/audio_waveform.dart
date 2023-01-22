// ignore_for_file: must_be_immutable, avoid_print
import 'package:flutter/material.dart';

class AudioWaveForm extends StatefulWidget {
  double amplitude;

  AudioWaveForm({Key key, this.amplitude}) : super(key: key);

  @override
  State<AudioWaveForm> createState() => _AudioWaveFormState();
}

class _AudioWaveFormState extends State<AudioWaveForm>
    with SingleTickerProviderStateMixin {
  List<double> audioData = [];

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    widget.amplitude = widget.amplitude + 62;
    audioData.add(widget.amplitude);
    return CustomPaint(
      size: Size(audioData.length + myWidth + 0, myHeight / 2),
      painter: DemoPainter(audioData),
      foregroundPainter: HorizontalLine(),
    );
  }
}

class HorizontalLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;
    final center = size / 2;
    canvas.drawLine(
        Offset(0, center.height), Offset(size.width, center.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DemoPainter extends CustomPainter {
  List<double> audioData;

  DemoPainter(this.audioData);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;

    var verticalLine = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    for (double i = 0; i < audioData.length; i++) {
      canvas.drawLine(Offset(0 + (i * 3), center.height),
          Offset(0 + (i * 3), 100 - audioData[i.toInt()]), verticalLine);

      canvas.drawLine(Offset(0 + (i * 3), center.height),
          Offset(0 + (i * 3), audioData[i.toInt()] + 100), verticalLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
