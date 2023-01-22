import 'package:flutter/material.dart';
import '../widgets/data_list_widget.dart';
import '../recording_data/sound_recorder.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({Key key}) : super(key: key);

  static const routeName = '/patient-detail';

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final patientId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Detail'),
      ),
      body: Column(
        children: [
          DataList(patientId.toString()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              width: double.infinity,
              // color: Colors.grey,
              child: const Text(
                'Recording',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SoundRecorderScreen.routeName);
            },
            child: const Text('Add Recording'),
          ),
        ],
      ),
    );
  }
}
