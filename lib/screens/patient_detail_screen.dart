// ignore_for_file: prefer_typing_uninitialized_variables, missing_return

import 'package:flutter/material.dart';
import '../recording_data/sound_recorder.dart';
import '../services/database.dart';
import '../widgets/data_list_widget.dart';
import '../widgets/player.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({Key key}) : super(key: key);

  static const routeName = '/patient-detail';

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  List<Map<String, dynamic>> patientDetail;
  bool isLoading = false;
  var patientId;
  DatabaseHelper dbHelper = DatabaseHelper();

  void getPatient(String id) async {
    setState(() {
      isLoading = true;
    });
    patientDetail = await dbHelper.fetchData(id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    patientId = ModalRoute.of(context).settings.arguments;
    getPatient(patientId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Detail'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                DataList(patientDetail),
                Expanded(
                  child: Container(
                    color: const Color(0xffE6e6e6),
                    margin:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                    height: 200,
                    child: FutureBuilder(
                      future: dbHelper.fetchAudio(patientId),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as List;

                            if (data.isEmpty) {
                              return const Center(
                                child: Text('No recording added yet.'),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: ((context, index) {
                                    return SizedBox(
                                      height: 60,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white70,
                                        child: Player(
                                          id: data[index]['audioId'],
                                          source: data[index]['file'],
                                          reBuild: () {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    );
                                  }));
                            }
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error has been occured.'),
                            );
                          }
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Text('No recording added yet.'),
                          );
                        }
                      }),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final res = await Navigator.of(context).pushNamed(
                        SoundRecorderScreen.routeName,
                        arguments: patientId);
                    if (res != null) {
                      setState(() {});
                    }
                  },
                  child: const Text('Add Recording'),
                ),
              ],
            ),
    );
  }
}
